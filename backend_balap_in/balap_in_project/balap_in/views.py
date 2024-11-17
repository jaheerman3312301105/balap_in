from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.decorators import api_view
from .serializers import LaporanSerializer
from .models import Laporan 
from rest_framework import status
import logging
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework.decorators import api_view, parser_classes

logger = logging.getLogger(__name__)

# Create your views here.

@api_view(['GET'])
def getLaporan(request):
    if request.method == 'GET':
        laporan = Laporan.objects.all()
        serializer = LaporanSerializer(laporan, many=True)
        return Response(serializer.data)
    else:
        print('NOT ALLOWED')

@api_view(['POST'])  
@parser_classes([MultiPartParser, FormParser])  
def createLaporan(request):
    if request.method == 'POST':
        gambar_file = request.FILES.get('gambar')  
        
        if gambar_file:
            gambar_biner = gambar_file.read()  
            
            laporan = Laporan(
                gambar=gambar_biner, 
                jenis=request.data.get('jenis'),
                judul=request.data.get('judul'),
                deskripsi=request.data.get('deskripsi'),
                persentase=request.data.get('persentase'),
                cuaca=request.data.get('cuaca'),
                status=request.data.get('status'),
                
            )
            
            laporan.save()
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