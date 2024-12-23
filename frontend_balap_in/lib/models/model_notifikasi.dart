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