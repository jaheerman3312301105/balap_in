import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:balap_in/api/api_service_laporan.dart';
import 'package:image_picker/image_picker.dart';

const List<String> jenis = <String>['Jalan', 'Lampu Jalan', 'Jembatan'];
const List<String> cuaca = <String>['Hujan', 'Cerah'];

String? selectedJenis = 'Jalan'; 
String? selectedCuaca = 'Hujan';
double _currentSliderValue = 0;

class LaporScreen extends StatefulWidget {
  const LaporScreen({super.key});

  @override
  _LaporScreenState createState() => _LaporScreenState();
}

class _LaporScreenState extends State<LaporScreen> {
  final ImagePicker picker = ImagePicker();

  final TextEditingController judulController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  @override
  void dispose() {
    judulController.dispose();
    super.dispose();
  }

  File? gambar;
  Uint8List? gambarBlob;
  String? gambarfix;

  Future<Uint8List?> gambarBytes(File file) async{
    return await file.readAsBytes();
  }

  Future getImageGallery() async{
    final pickedGallery = await picker.pickImage(source: ImageSource.gallery);
    setState(() async{
      if (pickedGallery != null){
        gambar = File(pickedGallery.path);
        gambarBlob = await gambarBytes(gambar!);
        setState(() {
          gambarfix = base64Encode(gambarBlob!);
        });
      }
    });
  }
  

  Future getImageCamera() async{
    final pickedCamera = await picker.pickImage(source: ImageSource.camera);
  }
  

  void buatLaporan(String status) {
    
    ApiServiceLaporan apiService = ApiServiceLaporan();
    apiService.buatLaporan(judulController.text, selectedJenis!, deskripsiController.text, status, _currentSliderValue, selectedCuaca, gambarBlob!);
  }

  Widget build(BuildContext context) {
    ImageProvider previewGambar;
    if (gambarBlob != null) {
      previewGambar = MemoryImage(gambarBlob!);
    } else {
      previewGambar = const AssetImage('assets/images/gambar.png');
    }
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
             Navigator.of(context).popUntil((route) => route.isFirst);
          }, 
          icon: const Icon(Icons.keyboard_arrow_left),
          color: const Color.fromRGBO(5, 5, 5, 0.612),
          iconSize: 40,),
        title: const SizedBox(
          child: Row(
            children: [
              Text.rich(
                TextSpan(
                  text: 'Buat Laporan',
                  style: TextStyle(
                    color: Color.fromRGBO(5, 5, 5, 0.612),
                    fontFamily: "Poppins",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                     shadows: [Shadow(
                      offset: Offset(1.0, 6.0),
                      blurRadius: 10,
                      color: Colors.black26,
                    ),
                    ]
                  ),
                ),
              ),
            ],
          ),
        ),
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
          child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 1),
                  const SizedBox(
                    width: 340,
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Judul Pengaduan',
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    width: 350,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 230, 228, 228),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(1, 5),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: judulController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Jalan berlubang di jalan raya piayu',
                          hintStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 10,
                          ),
                          contentPadding: EdgeInsets.only(
                            top: -12,
                            left: 9,
                          ),
                        ),
                      ),
                    ),
                  ),
        
                  //KODE WIDGET JENIS PENGADUAN
                  const SizedBox(height: 10),
                  const SizedBox(
                    width: 340,
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Jenis Pengaduan',
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 350,
                    height: 35,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 230, 228, 228),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(1, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                          width: 10,
                          ),
                          SizedBox(
                        width: 320,
                        height: 35,
                        child: DropdownButton<String>(
                          value: selectedJenis,
                          items: jenis.map<DropdownMenuItem<String>>((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item, style: const TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 10,
                              ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? item) {
                            setState(() {
                              selectedJenis = item;
                            }
                            );
                          },
                        ),
                        ),
                        ],
                      )
                    ),
                  ),
        
                  //KODE WIDGET DESKRIPSI PENGADUAN
                  const SizedBox(height: 10),
                  const SizedBox(
                    width: 340,
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Deskripsi Pengaduan',
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: 350,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 230, 228, 228),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(1, 5),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.only(
                        top: 12,
                        right: 2),
                      child: TextField(
                        controller: deskripsiController,
                        style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                        ),
                        cursorHeight: 14,
                        maxLines: 6,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Entah sudah selasa yang keberapa masih saja jalan itu rusak',
                          hintStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                          ),
                          contentPadding: EdgeInsets.only(
                            top: -8,
                            left: 9,
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  //KODE 2 WIDGET CUACA DAN PERSENTASE KERUSAKAN
                  Center(
                    child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 80,
                        width: 350,
                        child: Center(
                          child: Row(
                            children: [
                              SizedBox(
                                height: 80,
                                width: 150,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Cuaca',
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                    const Padding(padding: EdgeInsets.only(top: 10)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                    width: 150,
                                    height: 35,
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                      ),
                                      decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 230, 228, 228),
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 4,
                                          offset: const Offset(1, 5),
                                        ),
                                      ],
                                    ),
                                    child: DropdownButton<String>(
                                      icon: const Icon(Icons.arrow_drop_down_sharp),
                                      value: selectedCuaca,
                                      items: cuaca.map<DropdownMenuItem<String>>((String cuaca) {
                                        return DropdownMenuItem<String>(
                                          value: cuaca,
                                          child: Text(cuaca, style: const TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 10,
                                          ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? cuaca) {
                                        setState(() {
                                          selectedCuaca = cuaca;
                                        }
                                        );
                                      },
                                    ),
                                    ),
                                    ),
                                  ],
                                ),
                                ),
        
                                const SizedBox(
                                height: 80,
                                width: 50,
                                ),
        
                              SizedBox(
                                height: 80,
                                width: 150,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Persentase Kerusakan',
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                    const Padding(padding: EdgeInsets.only(top: 10)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 150,
                                      height: 35,
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                        left: 0,
                                        right: 2
                                        ),
                                        decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 230, 228, 228),
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            blurRadius: 4,
                                            offset: const Offset(1, 5),
                                          ),
                                        ],
                                      ),
                                      child: Slider(
                                        activeColor: const Color.fromARGB(255, 97, 96, 96),
                                        value: _currentSliderValue,
                                        max: 100,
                                        divisions: 5,
                                        label: _currentSliderValue.round().toString(),
                                        onChanged: (double value) {
                                          setState(() {
                                            _currentSliderValue = value;
                                          });
                                        },
                                      ),
                                      ),
                                    )
                                  ],
                                ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    ),
                  ),
                
                //KODE 2 WIDGET AMBIL GAMBAR DAN LOKASI MANUAL
                SizedBox(
                  width: 350,
                  height: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //KODE AMBIL GAMBAR
                      SizedBox(
                        width: 150,
                        height: 130,
                        child: Column(
                          children: [
                            const SizedBox(
                              width: 100,
                              height: 30,
                              child: Center(
                                child: Text(
                                      'Gambar',
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                              )
                            ),
                            InkWell(
                              onTap: () {
                                showCupertinoModalPopup(context: context, 
                                builder: (BuildContext context) {
                                  return CupertinoActionSheet(
                                    title: const Text('Ambil Gambar',
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold
                                    ),),
                                    actions: <CupertinoActionSheetAction>[
                                      CupertinoActionSheetAction(
                                        onPressed: (){
                                         getImageCamera();
                                        }, 
                                        child: Text('Kamera', 
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.6),
                                          fontFamily: "Poppins"
                                        ),)),
                                      CupertinoActionSheetAction(
                                        onPressed: (){
                                          getImageGallery();
                                        }, 
                                        child: Text('Galeri', 
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.6),
                                          fontFamily: "Poppins"
                                        ),))
                                    ],
                                  );
                                });
                              },
                              child: SizedBox(
                              width: 150,
                              height: 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 230, 228, 228),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: const Offset(1, 5),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 85,
                                      height: 70,
                                      child: Image(
                                        image: previewGambar,
                                      ),
                                    ),
                                    const SizedBox(
                                      child: Text(
                                        'Ambil gambar dari kamera atau galeri',
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 6,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              ),
                            ),
                          ],
                        ),
                      ),
        
                      const SizedBox(width: 50),
        
                       //KODE WIDGET LOKASI MANUAL
                      SizedBox(
                        width: 150,
                        height: 130,
                        child: Column(
                          children: [
                            const SizedBox(
                              width: 100,
                              height: 30,
                              child: Center(
                                child: Text(
                                      'Lokasi',
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                              )
                            ),
                            InkWell(
                              onTap: () {},
                              child: SizedBox(
                              width: 150,
                              height: 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 230, 228, 228),
                                  borderRadius: BorderRadius.circular(10),
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
                                    SizedBox(
                                      width: 85,
                                      height: 70,
                                      child: Image(
                                        image: AssetImage('assets/images/petainput.png'),
                                      ),
                                    ),
                                    SizedBox(
                                      child: Text(
                                        'Atur Lokasi',
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 6,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ),
                
                //KODE WIDGET ALAMAT LOKASI
                const SizedBox(height: 4),
                  const SizedBox(
                    width: 340,
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Alamat',
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    width: 350,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 230, 228, 228),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(1, 5),
                          ),
                        ],
                      ),
                      child: const TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Jl. Sudirman No.3, Sukajadi, Kec. Batam Kota, Kota Batam, Kepulauan Riau 29432',
                          hintStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 10,
                          ),
                          contentPadding: EdgeInsets.only(
                            top: -12,
                            left: 9,
                          ),
                        ),
                      ),
                    ),
                  ),
        
        
                  //WIDGET DRAFT ATAU KIRIM
                const SizedBox(height: 40),
                SizedBox(
                  width: 350,
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //WIDGET DRAFT
                      InkWell(
                        onTap: () {
                          buatLaporan('draft');
                        },
                        child: SizedBox(
                          width: 145,
                          height: 30,
                          child: Container(
                            decoration: BoxDecoration(
                                    color: const Color.fromARGB(113, 15, 15, 15),
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
                                  Text('Draft',
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10
                                  ),
                                  )
                                ],
                              ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      //WIDGET KIRIM
                      InkWell(
                        onTap: () {
                          buatLaporan('selesai');
                        },
                        child: SizedBox(
                          width: 145,
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
                                  Text('Kirim',
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10
                                  ),
                                  )
                                ],
                              ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //PEMISAH FOOTER
                const SizedBox(height: 20,)
        
        
        
                ],
              ),
            )
          ],
        ),
        ),
        ]
      )
    );
  }
}
