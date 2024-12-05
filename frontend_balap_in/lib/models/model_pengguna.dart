class Pengguna {
    final int idPengguna;
    final String nama;
    final String alamat;
    final String token;
    final String tglpengguna;


    Pengguna({
        required this.idPengguna,
        required this.nama,
        required this.alamat,
        required this.token,
        required this.tglpengguna
    });
    
    factory Pengguna.fromJson(Map<String, dynamic> json) {
        return Pengguna(
            idPengguna: json['id_pengguna'], 
            nama: json['nama'] ?? 'Pengguna', 
            alamat: json['alamat'] ?? 'Batam', 
            token: json['token'],
            tglpengguna: json['tgl_pengguna']
        );
    }
}