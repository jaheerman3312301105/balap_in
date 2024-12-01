import 'package:balap_in/api/api_service_mappicker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/model_laporan.dart';  

class ApiServiceLaporan {
  final dio = Dio();

  Future<List<Laporan>>fetchLaporan(selectedChipAnalisisIndex, searchController) async {
     String period;

    switch (selectedChipAnalisisIndex) {
      case 0:
        period = 'last_week';
        break;
      case 1:
        period = 'last_month';
        break;
      case 2:
        period = 'last_year';
        break;
      case 3:
        period = 'all';
        break;
      default:
        period = 'all';
    }
    
    try {
      Response response = await dio.get('http://10.0.2.2:8000/laporan/?period=$period&status=selesai&search=$searchController');
      if (response.statusCode == 200) {
        List data = response.data;
        return data.map((json) => Laporan.fromJson(json)).toList();
      } else {
        throw Exception("gagal memberikan data laporan");
      }
    } catch (e) {
      throw Exception("gagal mengambil data laporan: $e");
    }
  }

  Future<void> buatLaporan(String judul, jenis, deskripsi, status, persentase, cuaca, gambarBlob, pickedLocation) async {

    
    if (jenis == 'Jalan') {
      jenis = 'jalan';
    } else if (jenis == 'Lampu Jalan') {
      jenis = 'lampu_jalan';
    } else if (jenis == 'Jembatan') {
      jenis = 'jembatan';
    }

    persentase = persentase/100;

    if (cuaca == 'Cerah') {
      cuaca = 'cerah';
    } else if (cuaca == 'Hujan') {
      cuaca = 'hujan';
    }
  
    ApiServiceMappicker apiMap = ApiServiceMappicker();
    Map locationData = await apiMap.buatPeta(pickedLocation);
    
    try {
       FormData data = FormData.fromMap({
      "gambar": MultipartFile.fromBytes(gambarBlob, filename: 'image.png'), 
      "jenis": jenis,
      "judul": judul,
      "deskripsi": deskripsi,
      "persentase": persentase,
      "cuaca": cuaca,
      "status": status,
      "tingkat_urgent": null,
      "id_pengguna": null,
      "alamat": locationData['alamat'],
      "jalan": locationData['jalan'],
      "latitude": locationData['latitude'],
      "longitude": locationData['longitude'],
    });

      print(data.fields);

      print('Panjang gambar: ${gambarBlob.length}');

      final response = await dio.post(
        'http://10.0.2.2:8000/laporan/buat',
        data: data,
        options: Options(
          headers: {"Content-Type": "multipart/form-data"}
        )
      );

      if (response.statusCode == 201) {
        print('Laporan berhasil dibuat');
      } else {
        print('Gagal membuat laporan');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  
}
