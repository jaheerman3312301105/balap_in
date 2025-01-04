// Nama File: tutorial.dart
// Deskripsi: File ini berfungsi untuk menampilkan tutorial bagi pengguna untuk menggunakan aplikasi
// Dibuat oleh: Yulia Pipka Ziliwu - NIM: 3312301035
// Tanggal: Dec 10, 2024


import 'package:flutter/material.dart';

class Tutorial extends StatelessWidget {
  const Tutorial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.keyboard_arrow_left),
          color: const Color.fromRGBO(5, 5, 5, 0.612),
          iconSize: 40,
        ),
        title: const Text.rich(
          TextSpan(
            text: 'Cara Melapor',
            style: TextStyle(
              color: Color.fromRGBO(5, 5, 5, 0.612),
              fontSize: 18.0,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  offset: Offset(1.0, 6.0),
                  blurRadius: 10,
                  color: Colors.black26,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center, // Rata tengah untuk teks
          children: [
            // Gambar berada di paling atas, di bawah AppBar
            Image.asset(
              'assets/images/tutorial.png',
              width: double.infinity, // Gambar mengisi lebar layar
              fit: BoxFit.contain, // Memastikan gambar sesuai dengan ukuran aslinya
            ),
            const SizedBox(height: 20), // Spacer antara gambar dan teks
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0), // Menambahkan padding untuk teks
              child: Text(
                'Batam Lapor Infrastruktur\n',
                textAlign: TextAlign.center, // Rata tengah untuk teks
                style: TextStyle(
                  fontSize: 16.0, // Ukuran font yang lebih besar untuk teks ini
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold, // Menjadikan teks bold
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10), // Spacer antara teks "BALAP-IN siap" dan konten di bawahnya
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0), // Menambahkan padding untuk teks
              child: Text(
                'Anda bisa melaporkan jika:\n'
                '• Anda merupakan warga Kota Batam.\n'
                '• Melihat kerusakan infrastruktur seperti jalan, lampu penerangan, dan jembatan.\n\n'
                'Langkah-langkah melaporkan:\n'
                '1. Klik fitur “Lapor Sekarang!” pada halaman dashboard atau halaman ini.\n'
                '2. Isi judul pengaduan dan pilih jenis pengaduan.\n'
                '3. Lengkapi deskripsi pengaduan.\n'
                '4. Pilih cuaca (Cuaca saat anda membuat laporan).\n'
                '5. Pilih persentase (Persentase kerusakan menurut anda).\n'
                '6. Masukkan gambar dengan klik menu kamera.\n'
                '7. Inputkan lokasi.\n'
                '8. Klik Kirim.\n'
                '9. Laporan anda akan dikirimkan ke sistem.\n',
                textAlign: TextAlign.left, // Rata kiri untuk teks
                style: TextStyle(
                  fontSize: 12.0, // Ukuran font yang sesuai
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 30,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/lapor');
                },
                child: SizedBox(
                  width: 200,
                  height: 30,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(154, 21, 221, 21),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(1, 5),
                        ),
                      ],
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Lapor Sekarang',
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}