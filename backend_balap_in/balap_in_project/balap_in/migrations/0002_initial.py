# Generated by Django 5.1.2 on 2024-12-08 04:34

import django.db.models.deletion
import uuid
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('balap_in', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='laporan',
            name='cluster',
            field=models.IntegerField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='pengguna',
            name='tgl_pengguna',
            field=models.DateTimeField(auto_now=True),
        ),
        migrations.AddField(
            model_name='pengguna',
            name='token',
            field=models.CharField(default=uuid.uuid4, max_length=100),
        ),
        migrations.AlterField(
            model_name='analisis',
            name='jenis_infrastruktur',
            field=models.CharField(blank=True, choices=[('jalan', 'Jalan'), ('lampu_jalan', 'Lampu Jalan'), ('jembatan', 'Jembatan')], max_length=40, null=True),
        ),
        migrations.AlterField(
            model_name='laporan',
            name='cuaca',
            field=models.CharField(blank=True, choices=[('hujan', 'Hujan'), ('cerah', 'Cerah')], max_length=40, null=True),
        ),
        migrations.AlterField(
            model_name='laporan',
            name='id_pengguna',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='balap_in.pengguna'),
        ),
        migrations.AlterField(
            model_name='laporan',
            name='id_peta',
            field=models.OneToOneField(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='peta', to='balap_in.peta'),
        ),
        migrations.AlterField(
            model_name='laporan',
            name='jenis',
            field=models.CharField(blank=True, choices=[('jalan', 'Jalan'), ('lampu_jalan', 'Lampu Jalan'), ('jembatan', 'Jembatan')], max_length=40, null=True),
        ),
        migrations.AlterField(
            model_name='laporan',
            name='judul',
            field=models.CharField(blank=True, max_length=40, null=True),
        ),
        migrations.AlterField(
            model_name='laporan',
            name='status',
            field=models.CharField(blank=True, choices=[('selesai', 'Selesai'), ('draft', 'Draft')], max_length=40, null=True),
        ),
        migrations.AlterField(
            model_name='pengguna',
            name='alamat',
            field=models.CharField(blank=True, max_length=40, null=True),
        ),
        migrations.AlterField(
            model_name='pengguna',
            name='nama',
            field=models.CharField(blank=True, max_length=40, null=True),
        ),
        migrations.AlterField(
            model_name='peta',
            name='id_laporan',
            field=models.OneToOneField(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='laporan', to='balap_in.laporan'),
        ),
    ]
