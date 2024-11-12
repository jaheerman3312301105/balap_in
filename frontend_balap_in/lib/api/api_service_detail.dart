import 'package:dio/dio.dart';

class DetailApiService {
  Future<Map<String, dynamic>> fetchLaporan(String id) async {
  try {
    Dio dio = Dio();
    final url = 'http://127.0.0.1:8000/laporan/$id/';
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      return response.data;  
    } else {
      throw Exception('Failed to load laporan');
    }
  } catch (e) {
    throw Exception('Error fetching data: $e');
  }
}
}

