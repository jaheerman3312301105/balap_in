// Nama File: api_service_laporan.dart
// Deskripsi: File ini berfungsi untuk menangani layanan data laporan
// Dibuat oleh: Farhan Ramadhan - NIM: 3312301105
// Tanggal: Nov 10, 2024

import 'package:balap_in/api/api_service_mappicker.dart';
import 'package:balap_in/api/host.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/model_laporan.dart';  

class ApiServiceLaporan {
  final dio = Dio();

  // Fungsi untuk mendapatkan token pengguna
  Future<String?> getToken() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_token');
  }

  // fungsi untuk mendapatkan data laporan 
  Future<LaporanResponse> fetchLaporan(selectedChipAnalisisIndex, searchController) async {
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
      Response response = await dio.get('$host/laporan/?period=$period&status=selesai&search=$searchController');
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        return LaporanResponse.fromJson(data);
      } else {
        throw Exception("gagal memberikan data laporan");
      }
    } catch (e) {
      throw Exception("gagal mengambil data laporan: $e");
    }
  }

  // fungsi untuk membuat laporan yang valuenya diambil dari halaman lapor
  Future<void> buatLaporan(String judul, jenis, deskripsi, status, persentase, cuaca, gambarBlob, pickedLocation) async {
    String? token = await getToken();
    
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
      "token" : token,
    });

      print(data.fields);

      print('Panjang gambar: ${gambarBlob.length}');

      final response = await dio.post(
        '$host/laporan/buat',
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

  // fungsi untuk mendapatkan data laporan sesuai dengan cluster nya untuk di halaman isi rekomendasi
  Future<List<Laporan>> getClusterLaporan(cluster) async{

    try{
      Response response = await dio.get('$host/laporan/cluster/$cluster/');

      if (response.statusCode == 200) {
         List<dynamic> responseData = response.data;
          List<Laporan> laporanList = responseData
            .map((dynamic item) => Laporan.fromJson(item))
            .toList();
            print(laporanList);
            return laporanList;
      } else {
        throw Exception('Error get cluster');
      }

    } catch(e) {
      throw Exception('Error cluster laporan: $e');
    }
  }
  
}
