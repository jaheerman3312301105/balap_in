// Nama File: model_peta.dart
// Deskripsi: File ini berfungsi untuk menampilkan marker lokasi dan menampilkan detail lokasi dan menyimpan data lokasi
// Dibuat oleh: Farhan Ramadhan - NIM: 3312301105
// Tanggal:  Dec 22, 2024

class Peta {

  final int idpeta;
  final String alamat;
  final String jalan;
  final double latitude;
  final double longitude;

  Peta({
    required this.idpeta,
    required this.alamat,
    required this.jalan,
    required this.latitude,
    required this.longitude,
  });

  factory Peta.fromJson(Map<String, dynamic> json) {
    return Peta(
      idpeta: json['id_peta'],
      alamat: json['alamat'],
      jalan: json['jalan'],
      latitude: json['latitude'],
      longitude: json['longitude']
      );
  }

}