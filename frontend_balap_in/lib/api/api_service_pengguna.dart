// Nama File: api_service_pengguna.dart
// Deskripsi: File ini berfungsi untuk menangani layanan pembuatan dan autentikasi pengguna
// Dibuat oleh: Farhan Ramadhan - NIM: 3312301105
// Tanggal: Dec 5, 2024

import 'package:balap_in/api/host.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServicePengguna {
  final dio = Dio();

  // fungsi untuk menginisialisasi kerja yang tugasnya mengambil token pengguna dari cache yang telah disimpan pengguna
  Future<void> initToken() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('user_token');

    if (token != null) {
      print('Token ditemukan {$token}');
      authPengguna(token);
    } else if (token == null) {
      print('Token tidak ditemukan, membuat token baru');
      await buatPengguna();
    } else {
      print('Token tidak bekerja');
    }
  }

  // fungsi untuk mengautentikasi token pengguna 
  Future<void> authPengguna(String token) async{
    try {
      Response response = await dio.post('$host/authpengguna',
        data: {'token' : token}
      );

      if (response.statusCode == 200) {
        print('Berhasil Mengautentikasi Pengguna');
      }
      else if (response.statusCode == 401) {
        print('Anda tidak memiliki akses ini');
      } else {
        print(response.data);
      }

    } catch (e) {
      throw Exception('Gagal Mengautentikasi Pengguna');
    }
  }

  // fungsi untuk membuat token pengguna jika pada cache pengguna tidak memilikinya
  Future<void> buatPengguna() async {
    try {
      Response response = await dio.post('$host/buatpengguna');
      print(response.data);

      if (response.statusCode == 201) {
        print('BERHASIL MEMBUAT PENGGUNA');
        String token = response.data['token'];
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_token', token);
        print('Melakukan Set token pengguna : {$token}');

      } else if (response.statusCode == 400) {
        print('GAGAL MEMBUAT PENGGUNA');
      
      } else {
        print('Method tidak diizinkan');
      }

    } catch (e) {
      throw Exception('Terjadi Kesalahan : $e');
    }
  }
}