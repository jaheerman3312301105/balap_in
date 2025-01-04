// Nama File: model_laporan.dart
// Deskripsi: File ini berfungsi untuk mengambil notifikasi dan mengintegrasikan dengan model rekomendasi
// Dibuat oleh: Farhan Ramadhan - NIM: 3312301105
// Tanggal:  Dec 30, 2024

import 'package:balap_in/models/model_rekomendasi.dart';

class Notifikasi {
  final int idNotifikasi;
  final String? pesan;
  final String? tglnotif;
  final Rekomendasi? rekomendasi;

  Notifikasi({
    required this.idNotifikasi,
    required this.pesan,
    required this.tglnotif,
    required this.rekomendasi
  });

  factory Notifikasi.fromJson(Map<String, dynamic> json){
    return Notifikasi(
      idNotifikasi: json['id_notifikasi'], 
      pesan: json['pesan'], 
      tglnotif: json['tgl_notif'], 
      rekomendasi: json['id_rekomendasi'] != null ? Rekomendasi.fromJson(json['id_rekomendasi']) : null
    );
  }

}