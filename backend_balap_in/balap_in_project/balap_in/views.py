from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.decorators import api_view
from .serializers import LaporanSerializer
from .serializers import PenggunaSerializer
from .serializers import RekomendasiSerializer
from .serializers import Analisis
from .models import Laporan 
from .models import Peta
from .models import Pengguna
from .models import Rekomendasi
from .models import Analisis
import uuid
from rest_framework import status
import logging
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework.decorators import api_view, parser_classes
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import filters
from rest_framework import status
from datetime import timedelta, datetime
from django.utils.timezone import now
from django.db.models import Q
from .management.commands.clustering import clustering
from .management.commands.recommendation import recommendations

logger = logging.getLogger(__name__)
# Create your views here.

@api_view(['POST'])
def createPengguna(request):
    if request.method == 'POST':
        try:
            token = str(uuid.uuid4())

            pengguna = Pengguna.objects.create(
                token = token
            )

            pengguna.save()
            return Response({'token' : token}, status=status.HTTP_201_CREATED)
        except :
            return Response({'Gagal mendaftarkan pengguna'}, status=status.HTTP_400_BAD_REQUEST)
    else:
        return Response({'Error': 'Method tidak diizinkan'}, status=status.HTTP_405_METHOD_NOT_ALLOWED)
    
@api_view(['POST'])
def authPengguna(request):
    token = request.data.get('token')
    if token:
        try:
            pengguna = Pengguna.objects.get(token=token)
            serializer = PenggunaSerializer(pengguna)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except:
            return Response({'Anda tidak memiliki akses ini'}, status=status.HTTP_401_UNAUTHORIZED)
    else:
        return Response({'message': 'Token tidak diberikan'}, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
def getLaporan(request):

    if request.method == 'GET':
        
        period = request.query_params.get('period', 'all') 
        status_filter = request.query_params.get('status', None)
        search_query = request.query_params.get('search', '')

        laporan = Laporan.objects.all().select_related('id_peta')

        current_time = now()
        if period == 'last_week':
            start_date = current_time - timedelta(weeks=1)
            laporan = laporan.filter(tgl_lapor__gte=start_date)
        elif period == 'last_month':
            start_date = current_time - timedelta(days=30)
            laporan = laporan.filter(tgl_lapor__gte=start_date)
        elif period == 'last_year':
            start_date = current_time - timedelta(days=365)
            laporan = laporan.filter(tgl_lapor__gte=start_date)

        if status:
            laporan = laporan.filter(status=status_filter)

        if search_query:
            laporan = laporan.filter(
                Q(judul__icontains=search_query) |
                Q(jenis__icontains=search_query) |
                Q(deskripsi__icontains=search_query) |
                Q(id_peta__alamat__icontains=search_query)
            )
        
        dominant_jenis = Laporan.get_dominant_jenis()

        serializer = LaporanSerializer(laporan, many=True)
        return Response({
            "laporan" : serializer.data,
            "dominant_jenis" : dominant_jenis
            })

    else:
        return Response({'Error': 'Method tidak diizinkan'}, status=status.HTTP_405_METHOD_NOT_ALLOWED)

@api_view(['POST'])  
@parser_classes([MultiPartParser, FormParser])  
def createLaporan(request):
    if request.method == 'POST':
        gambar_file = request.FILES.get('gambar')  
        token = request.data.get('token')
        if gambar_file:
            gambar_biner = gambar_file.read()  
            
            try:
                pengguna = Pengguna.objects.get(token=token)
                peta = Peta.objects.create(
                    alamat=request.data.get('alamat'),
                    jalan=request.data.get('jalan'),
                    latitude=request.data.get('latitude'),
                    longitude=request.data.get('longitude'),
                )
                 
                laporan = Laporan.objects.create(
                    gambar=gambar_biner, 
                    jenis=request.data.get('jenis'),
                    judul=request.data.get('judul'),
                    deskripsi=request.data.get('deskripsi'),
                    persentase=request.data.get('persentase'),
                    cuaca=request.data.get('cuaca'),
                    status=request.data.get('status'),
                    id_pengguna=pengguna
                )
            
                peta.id_laporan = laporan
                laporan.id_peta = peta
                peta.save()
                laporan.save()

                if Response(status=status.HTTP_201_CREATED):
                    clustering()

            except Exception as e:
                logger.error(f"Error:{e}")
            
            return Response({"message": "Laporan berhasil dibuat"}, status=status.HTTP_201_CREATED)
    else:
        return Response({"error": "Gambar tidak ditemukan"}, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
def detailLaporan(request, id_laporan):
    try:
        laporan = Laporan.objects.get(id_laporan=id_laporan)
        serializer = LaporanSerializer(laporan)
        return Response(serializer.data)
    except Laporan.DoesNotExist:
        print("Laporan tidak ditemukan")

@api_view(['GET'])
def rekomendasi(request, order):
    try:  

        if order == 'asc':
            rekomendasi = Rekomendasi.objects.all().order_by('tingkat_urgent')
        else:
            rekomendasi = Rekomendasi.objects.all().order_by('-tingkat_urgent')
        
        
        serializer = RekomendasiSerializer(rekomendasi, many=True)
        return Response(serializer.data)
    except Laporan.DoesNotExist:
        print("Rekomendasi tidak ditemukan")

@api_view(['GET'])
def detailrekomendasi(request, id_rekomendasi):
    try:
        rekomendasi = Rekomendasi.objects.get(id_rekomendasi=id_rekomendasi)
        serializer = RekomendasiSerializer(rekomendasi)
        return Response(serializer.data)
    except Rekomendasi.DoesNotExist:
        print('Tidak ada detail Rekomendasi')

@api_view(['GET'])
def getclusteroflaporan(request, cluster):
    try:
        clusterlaporan = Laporan.objects.filter(cluster=cluster)
        serializer = LaporanSerializer(clusterlaporan, many=True)
        return Response(serializer.data)
    except Laporan.DoesNotExist:
        print('Tidak ada cluster laporan')

@api_view(['GET'])
def recommend(request):
    try:
        pesan = recommendations()

        if not pesan:
            return Response({"message": "Tidak ada notifikasi baru."}, status=status.HTTP_200_OK)
        
        return Response({"message": pesan}, status=status.HTTP_200_OK)
    
    except Exception as e:
        logger.error(f"Error saat memanggil fungsi recommendations: {e}")
        return Response({"message": "Terjadi kesalahan saat memproses rekomendasi."}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
