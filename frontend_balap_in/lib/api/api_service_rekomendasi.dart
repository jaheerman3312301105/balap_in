// Nama File: api_service_rekomendasi.dart
// Deskripsi: File ini berfungsi untuk menangani layanan data rekomendasi
// Dibuat oleh: Farhan Ramadhan - NIM: 3312301105
// Tanggal: Nov 15, 2024

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:balap_in/models/model_rekomendasi.dart';
import 'host.dart';

class ApiServiceRekomendasi {
  final Dio _dio = Dio();
  
  // fungsi layanan API untuk mendapatkan data rekomendasi yang diberikan untuk marker peta
  Future<List<Rekomendasi>> fetchRekomendasiBiasa() async {
    try {
      Response response = await _dio.get('$host/rekomendasibiasa/');

      if(response.statusCode == 200) {
        final data = response.data as List;
        return data.map((item) => Rekomendasi.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch rekomendasi biasa : ${response.statusCode}');
      }

    } catch (e) {
      throw Exception('Failed to fetch rekomendasibiasa: $e');
    }
  }

  // fungsi layanan API untuk mendapatkan data rekomendasi sesuai dengan filter dari rendah ketinggi atau sebaliknya
  Future<List<Rekomendasi>> fetchRekomendasi(order) async {
    try {
      Response response = await _dio.get('$host/rekomendasi/$order');

      if (response.statusCode == 200) {
        final data = response.data as List;
        return data.map((item) => Rekomendasi.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch recommendations: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  // fungsi layanan API untuk mendapatkan detail atau isi dari rekomendasi
  Future<Rekomendasi> fetchDetailRekomendasi(int idrekomendasi) async {
  Dio dio = Dio();
  try {
    Response response = await dio.get('$host/rekomendasi/$idrekomendasi');
    if (response.statusCode == 200) {
      final data = response.data;
      return Rekomendasi.fromJson(data);
    } else {
      throw Exception('Failed to fetch detail of Rekomendasi: Status code ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error fetching detail of Rekomendasi: $e');
  }
}

}
