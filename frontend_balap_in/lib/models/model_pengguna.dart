// Nama File: model_pengguna.dart
// Deskripsi: File ini berfungsi untuk menyimpan informasi pengguna yang aktif dan mengelola token autentikasi
// Dibuat oleh: Farhan Ramadhan - NIM: 3312301105
// Tanggal:  Dec 22, 2024

class Pengguna {
    final int idPengguna;
    final String token;
    final String tglpengguna;


    Pengguna({
        required this.idPengguna,
        required this.token,
        required this.tglpengguna
    });
    
    factory Pengguna.fromJson(Map<String, dynamic> json) {
        return Pengguna(
            idPengguna: json['id_pengguna'], 
            token: json['token'],
            tglpengguna: json['tgl_pengguna']
        );
    }
}