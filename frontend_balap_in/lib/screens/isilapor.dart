import 'package:flutter/material.dart';

class IsilaporScreen extends StatelessWidget {
  const IsilaporScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leadingWidth:
              40, // Mengurangi lebar leading untuk mendekatkan ikon ke teks
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: null, // Action to go back
          ),
          title: const Padding(
            padding: EdgeInsets.only(
                left:
                    -8.0), // Menambahkan padding ke kiri untuk mendekatkan teks dengan ikon
            child: Text(
              "Judul Laporan",
              style: TextStyle(
                fontFamily: 'Poppins', // Menggunakan font Poppins
                fontWeight: FontWeight.bold,
                fontSize: 20,
                shadows: [
                  Shadow(
                    blurRadius: 4.0,
                    color: Colors.grey,
                    offset: Offset(1.0, 1.0),
                  ),
                ],
              ),
            ),
          ),
          elevation: 0, // Menghilangkan bayangan AppBar
          backgroundColor: Colors.transparent, // Membuat AppBar transparan
        ),
        body: Stack(
          clipBehavior:
              Clip.none, // Memungkinkan elemen berada di luar boundary
          children: [
            Positioned(
              left:
                  -110, // Posisikan lebih ke kiri agar menyentuh batas kiri layar
              top: -60, // Naikkan posisinya agar menyentuh AppBar
              child: Container(
                width: 250, // Memperbesar lingkaran agar lebih sesuai
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.pink.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0), // Menghapus padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Menggunakan Container untuk menambahkan shadow pada gambar
                  Container(
                    width: double.infinity, // Lebar gambar diatur ke infinity
                    height: 200, // Memberikan tinggi tetap
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(8), // Membulatkan sudut
                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.black.withOpacity(0.3), // Warna bayangan
                          blurRadius: 10, // Jarak blur bayangan
                          offset: const Offset(0, 4), // Offset bayangan
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(8), // Membulatkan sudut gambar
                      child: Image.asset(
                        'assets/images/jalanrusak.jpg',
                        fit: BoxFit
                            .cover, // Gambar memenuhi lebar tanpa mengubah proporsi
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Jalan berlubang parah sudah 5 bulan",
                      style: TextStyle(
                        fontFamily: 'Poppins', // Menggunakan font Poppins
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Jalan Sudirman No.3, Sukajadi, Kec. Batam Kota, Kota Batam, Kepulauan Riau 29432",
                      style: TextStyle(
                        fontFamily: 'Poppins', // Menggunakan font Poppins
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Dilaporkan: 25 July 2024",
                      style: TextStyle(
                        fontFamily: 'Poppins', // Menggunakan font Poppins
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
