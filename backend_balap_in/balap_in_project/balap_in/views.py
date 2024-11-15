from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.decorators import api_view
from .serializers import LaporanSerializer
from .models import Laporan 
from rest_framework import status
import logging

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
def createLaporan(request):
    if request.method == 'POST':
        serializer = LaporanSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
def detailLaporan(request, id_laporan):
    try:
        laporan = Laporan.objects.get(id_laporan=id_laporan)
        serializer = LaporanSerializer(laporan)
        return Response(serializer.data)
    except Laporan.DoesNotExist:
        print("Laporan tidak ditemukan")