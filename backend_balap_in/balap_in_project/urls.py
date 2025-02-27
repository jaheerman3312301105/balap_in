#  Nama File: urls.py
#  Deskripsi: File ini berfungsi untuk menangani routing pada logic views yang telah dibuat untuk dikirim ke API
#  Dibuat oleh: Farhan Ramadhan - NIM: 3312301105
#  Tanggal: Oct 31, 2024

from .balap_in import views
"""
URL configuration for balap_in_project project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from django.conf import settings
from django.conf.urls.static import static
from django.urls import re_path
from .consumer import NotificationConsumer

websocket_urlpatterns = [
    re_path(r"ws/notifications/", NotificationConsumer.as_asgi()),
]

urlpatterns = [
    path('admin/', admin.site.urls),
    path('buatpengguna', views.createPengguna),
    path('authpengguna', views.authPengguna, name='authPengguna'),
    path('laporan/', views.getLaporan),
    path('laporan/buat', views.createLaporan),
    path('laporan/<int:id_laporan>/', views.detailLaporan, name='detailLaporan'),
    path('rekomendasi/<int:id_rekomendasi>/', views.detailrekomendasi, name='detailrekomendasi'),
    path('rekomendasi/<str:order>/', views.rekomendasi, name='orderrekomendasi'),
    path("laporan/cluster/<int:cluster>/", views.getclusteroflaporan, name='clusterlaporan'),
    path('notifikasi/', views.getNotifikasi, name='notifikasi'),
    path('rekomendasibiasa/', views.rekomendasibiasa),
] 

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
