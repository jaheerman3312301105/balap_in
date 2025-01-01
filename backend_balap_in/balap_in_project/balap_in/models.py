from django.db import models
from django.db.models import Count
import uuid
from django.utils import timezone

now = timezone.now()

# Create your models here.
class Pengguna(models.Model): 
    id_pengguna = models.AutoField(primary_key=True)
    token = models.CharField(max_length=100, default=uuid.uuid4)
    tgl_pengguna = models.DateTimeField(default=now)
    class Meta :
        db_table ='pengguna'

class Laporan(models.Model):
    id_laporan = models.AutoField(primary_key=True)
    id_pengguna = models.ForeignKey(Pengguna, on_delete=models.CASCADE, null=True, blank=True)
    id_peta = models.OneToOneField('Peta' , on_delete=models.CASCADE, related_name='peta',null=True, blank=True)
    gambar = models.BinaryField(null=True, blank=True)
    jenis = models.CharField(
        max_length=40,
        choices=[('jalan', 'Jalan'), ('lampu_jalan', 'Lampu Jalan'), ('jembatan', 'Jembatan')],
        null=True, blank=True
    )
    judul = models.CharField(max_length=40, null=True, blank=True)
    deskripsi = models.CharField(max_length=100, null=True, blank=True)
    persentase = models.FloatField(null=True, blank=True)
    cuaca = models.CharField(
        max_length=40,
        choices=[('hujan', 'Hujan'), ('cerah', 'Cerah')],
        null = True, blank=True
    )
    status = models.CharField(
        max_length=40,
        choices=[('selesai', 'Selesai'), ('ditangani', 'Ditangani')],
        null=True, blank=True
    )
    tgl_lapor = models.DateTimeField(default=now)
    cluster = models.IntegerField(
        null=True, blank=True
    )
    
    def get_dominant_jenis():
        dominant = (
            Laporan.objects.values('jenis')
            .annotate(total=Count('jenis'))
            .order_by('-total')
            .first()
        )

        return dominant['jenis'] if dominant else None

    class Meta:
        db_table = 'laporan'


class Peta(models.Model):
    id_peta = models.AutoField(primary_key=True)
    id_laporan = models.OneToOneField(Laporan, on_delete=models.CASCADE, related_name='laporan', null=True, blank=True)
    alamat = models.CharField(
        max_length=255,
        null=True, blank=True
    )
    jalan = models.CharField(
        max_length=255,
        null=True, blank=True
    )
    latitude = models.FloatField(null=True, blank=True)
    longitude = models.FloatField(null=True, blank=True)

    class Meta:
        db_table = 'peta'

class Rekomendasi(models.Model):
    id_rekomendasi = models.AutoField(primary_key=True)
    id_laporan = models.ForeignKey(Laporan, on_delete=models.CASCADE)
    id_peta = models.ForeignKey(Peta, on_delete=models.CASCADE)
    status_urgent = models.CharField(
        max_length=10,
        choices=[('tinggi', 'Tinggi'), ('sedang', 'Sedang'), ('rendah', 'Rendah')],
        null=True, blank=True
    )
    tingkat_urgent = models.FloatField(
        null=True, blank=True
    )
    jumlah_laporan = models.IntegerField(
        null=False, 
    )

    class Meta:
        db_table = 'rekomendasi'
        constraints = [
            models.UniqueConstraint(fields=['id_laporan_id', 'id_peta_id'], name='unique_laporan_peta')
        ]

    def __str__(self):
        return f"Laporan ID: {self.id_laporan_id}, Peta ID: {self.id_peta_id}"


class Notifikasi(models.Model):
    id_notifikasi = models.AutoField(primary_key=True)
    id_rekomendasi = models.ForeignKey(Rekomendasi, on_delete=models.CASCADE)
    pesan = models.CharField(
        max_length=255,
        null=False,
    )
    tgl_notif = models.DateTimeField(default=now)

    class Meta:
        db_table = 'notifikasi'
