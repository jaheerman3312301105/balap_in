from rest_framework import serializers
from .models import Pengguna
from .models import Laporan
from .models import Peta
from .models import Rekomendasi
from .models import Analisis
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

class PetaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Peta
        fields = '__all__'

class RekomendasiSerializer(serializers.ModelSerializer):
    class Meta:
        model = Rekomendasi
        fields = '__all__'

class AnalisisSerializer(serializers.ModelSerializer):
    class Meta:
        model = Analisis
        fields = '__all__'

class NotifikasiSerializer(serializers.ModelSerializer):
    class Meta:
        model = Notifikasi
        fields = '__all__'

