from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.decorators import api_view
from .serializers import LaporanSerializer
from .models import Laporan 
from rest_framework import status
# Create your views here.

@api_view(['GET'])
def laporan(request):
    laporan = Laporan.objects.all()
    serializer = LaporanSerializer(laporan, many=True)
    return Response(serializer.data)
