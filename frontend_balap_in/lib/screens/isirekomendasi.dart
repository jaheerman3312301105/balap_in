import 'package:flutter/material.dart';

class IsiRekomendasiScreen extends StatefulWidget {
  const IsiRekomendasiScreen({super.key});

  @override
  _IsiRekomendasiScreenState createState() => _IsiRekomendasiScreenState();
}

class _IsiRekomendasiScreenState extends State<IsiRekomendasiScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
             Navigator.of(context).pop();
          }, 
          icon: const Icon(Icons.keyboard_arrow_left),
          color: const Color.fromRGBO(5, 5, 5, 0.612),
          iconSize: 40,),
          titleSpacing: 0,
          title: const SizedBox(
          width: 320,
          child: FittedBox(
              child: Text(
            'Jalan Berlubang Parah Sudah 5 Bulan',
            style: TextStyle(
            color: Color.fromRGBO(5, 5, 5, 0.612),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 18,
             shadows: [Shadow(
              offset: Offset(1.0, 6.0),
              blurRadius: 10,
              color: Colors.black26,
                  ),
                  ]
                ),
              ),
            )
          )
      ),
      body: Stack(
        children: [
          Positioned(
            top: -50, 
            left: -75,
            child: Container(
              width: 250,
              height: 250,
              decoration: const BoxDecoration(
                color: Color(0xFFF7E0E0),
                shape: BoxShape.circle,
              ),
            ),
          ),

          SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
        
                //KODE TEXT KATEGORI
                const Padding(
                  padding: EdgeInsets.only(
                  top: 20
                  ),
                child: SizedBox(
                  width: 380,
                  height: 20,
                  child: Text('Kategori: Jalan Rusak',
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 9
                    ),
                    ),
                  ),
                ),
        
                //KODE TEKS ALAMAT
                const Padding(
                  padding: EdgeInsets.only(
                  bottom: 17
                  ),
                child: SizedBox(
                  width: 380,
                  height: 20,
                  child: Text('Jl. Sudirman No.3, Sukajadi, Kec. Batam Kota, Kota Batam, Kepulauan Riau 29432',
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 9
                    ),
                    ),
                  ),
                ),
        
                //KODE TEKS DOKUMENTASI LAPORAN
                const Padding(
                  padding: EdgeInsets.only(
                  ),
                child: SizedBox(
                  width: 380,
                  height: 17,
                  child: Text('Dokumentasi Laporan',
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 9
                    ),
                    ),
                  ),
                ),
                
                //KODE GARIS BATAS TEKS DOKUMENTASI LAPORAN DENGAN GAMBAR
                const SizedBox(
                  height: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.black,
                          thickness: 1.5,
                        )
                      )
                    ],
                  ),
                ),
        
                //KODE GAMBAR DOKUMENTASI LAPORAN
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                    bottom: 12
                    ),
                  child: SizedBox(
                  width: 380,
                  child: Wrap(
                    spacing: 9.0,
                    runSpacing: 12.0, 
                    children: List.generate(20, (index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/isilapor');
                        },
                        child: const SizedBox(
                          width: 185,
                          height: 110,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Image(
                              image: AssetImage('assets/images/jalanrusak.jpg') 
                              ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                )
        
        
              ],
            ),
          ),
        ),
        ]
      ),

    );
  }
}