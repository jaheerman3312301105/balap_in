import 'dart:async';

import 'package:dio/dio.dart';
import 'package:balap_in/models/model_rekomendasi.dart';
import 'host.dart';

class ApiServiceRekomendasi {
  final Dio _dio = Dio();
  
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
