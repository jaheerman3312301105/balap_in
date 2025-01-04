#  Nama File: serializers.py
#  Deskripsi: File ini berfungsi untuk menangani struktur pemodelan menjadi dalam bentuk format json
#  Dibuat oleh: Farhan Ramadhan - NIM: 3312301105
#  Tanggal: Oct 31, 2024

from rest_framework import serializers
from .models import Pengguna
from .models import Laporan
from .models import Peta
from .models import Rekomendasi
from .models import Notifikasi

class PenggunaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Pengguna
        fields = '__all__'

class LaporanSerializer(serializers.ModelSerializer):
    class Meta:
        model = Laporan
        fields = '__all__'
        depth = 1

    def get_dominant_jenis():
        return Laporan.get_dominant_jenis()

class PetaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Peta
        fields = '__all__'

class RekomendasiSerializer(serializers.ModelSerializer):
    class Meta:
        model = Rekomendasi
        fields = '__all__'
        depth = 1

class NotifikasiSerializer(serializers.ModelSerializer):
    class Meta:
        model = Notifikasi
        fields = '__all__'
        depth = 2

