import 'dart:math';

import 'package:flutter/material.dart';
import 'package:balap_in/widgets/homewidget.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:filter_list/filter_list.dart';

MapController mapController = MapController();

bool showAdditionalChip = false;
bool filterSelected = false;

bool filterAnalisisSelected = false;
int selectedChipAnalisisIndex = 0;
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
} 
  
class _HomeScreenState extends State<HomeScreen> {
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text.rich(
            TextSpan(
              text: 'Halo, Selamat Datang di ',
              style: TextStyle(
                color: Color.fromRGBO(5, 5, 5, 0.612),
                fontSize: 18.0,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 6.0),
                    blurRadius: 10,
                    color: Colors.black26,
                  ),
                ],
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'BALAP-IN',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),

          Center(
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 250, 204, 204),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2), 
                          blurRadius: 4, 
                          offset: const Offset(3, 5), 
                      )
                    ]
                  ),
                  child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                  Navigator.pushNamed(context, '/notifikasi');
                },
                  child: const Icon(
                    Icons.notifications,
                ),
                ),
              ),
          )
          ]
        ),
      ),

      body: Column(
        children: <Widget>[
          Container(
            height: 150,
            width: 410,
            margin: const EdgeInsets.only(
              top: 10,
              bottom: 20,
            ),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(-4.0, 5.0),
                  blurRadius: 5.0,
                )
              ],
            ),
            child: OSMViewer(
                controller: SimpleMapController(
                  initPosition: GeoPoint(
                    latitude: 1.118512,
                    longitude: 104.048477,
                  ),
                  markerHome: const MarkerIcon(
                    icon: Icon(Icons.home),
                  ),
                ),
                zoomOption: const ZoomOption(
                  initZoom: 11,
                  minZoomLevel: 10,
                ),
              ),
            ),

          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                        top: 2,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5), 
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2), 
                              blurRadius: 4, 
                              offset: const Offset(1, 7), 
                            ),
                          ],
                        ),
                        child: const SizedBox(
                        width: 340,
                        height: 45,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11
                            ),
                            cursorColor: Colors.black,
                            cursorHeight: 20,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(9)
                                ),
                              borderSide: BorderSide.none
                              ),
                              hintText: 'Cari Laporan',
                              hintStyle: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 11,
                              ),
                              suffixIcon: Icon(
                                color: Colors.black,
                                Icons.search,
                              ),
                            ),
                          ),
                        ),
                      ),
                      )
                    ),

                    Container(
                      width: 280,
                      height: 80,
                      margin: const EdgeInsets.only(
                        top: 5,
                      ),
                      child: SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/tutorial');
                              },
                              child: SizedBox(
                                height: 80,
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      alignment: Alignment(0, -0.5),
                                      image:
                                          AssetImage('assets/images/question.png'),
                                    ),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        offset: Offset(1.0, 5.0),
                                        blurRadius: 5.0,
                                        color: Colors.black26,
                                      ),
                                    ],
                                  ),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Cara Melapor',
                                        style: TextStyle(
                                          fontSize: 7,
                                          fontFamily: "Poppins",
                                        ),
                                      ),
                                      SizedBox(height: 7),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/lapor');
                              },
                              child: Container(
                                margin: const EdgeInsets.only(left: 20),
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(1.0, 5.0),
                                      blurRadius: 5.0,
                                      color: Colors.black26,
                                    ),
                                  ],
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 58,
                                      width: 80,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            alignment: Alignment(0, -0.5),
                                            image: AssetImage(
                                                "assets/images/writing.png"),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Lapor sekarang',
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 7,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/rekomendasi');
                              },
                              child: Container(
                                margin: const EdgeInsets.only(left: 20),
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(1.0, 5.0),
                                      blurRadius: 5.0,
                                      color: Colors.black26,
                                    )
                                  ],
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 57,
                                      width: 80,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/chart.png"),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Rekomendasi Urgensi',
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 6.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    //TOMBOL PERIODE ANALISIS
                    const SizedBox(height: 14,),
                    SizedBox(
                      height: 25,
                      width: 350,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 25,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(1.0, 3.0),
                                    blurRadius: 3
                                  )
                                ]
                              ),
                              child: RawChip(
                                label: const FittedBox(
                                  fit: BoxFit.scaleDown, 
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.timeline, color: Colors.black, size: 18,),
                                      Text(
                                        'Analisis Berdasarkan',
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 7, 
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                selected: filterSelected,
                                onSelected: (bool value) {
                                  setState(() {
                                    filterSelected = value;
                                    showAdditionalChip = value;
                                  });
                                },
                                backgroundColor: Colors.white, 
                                selectedColor: const Color.fromARGB(255, 250, 204, 204),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: const BorderSide(
                                    color: Colors.white
                                  )
                                ),
                                showCheckmark: false,
                                labelPadding: const EdgeInsets.only(
                                  top: -1,
                                  bottom: 3
                                ),
                                padding: const EdgeInsets.only(
                                  top: -1,
                                  bottom: 3,
                                  left: 1,
                                  right: 1
                                ),
                              ),
                            )
                          )
                        ],
                      )
                    ),
                    const SizedBox(height: 5,),
                    
                    if (showAdditionalChip)
                    SizedBox(
                        height: 40,
                          child: ListView(
                            padding: const EdgeInsets.only(
                              left: 5,
                              right: 5
                            ),
                            scrollDirection: Axis.horizontal,
                            children: [
                              SizedBox(
                                height: 40,
                                child: ChoiceChip(
                                  side: BorderSide.none,
                                  backgroundColor: const Color.fromARGB(255, 231, 230, 230),
                                  selectedColor: const Color.fromARGB(255, 250, 204, 204),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  label: const Text('Seminggu terakhir',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold
                                  ),), 
                                  selected: selectedChipAnalisisIndex == 0,
                                  onSelected: (bool value) {
                                    setState(() {
                                      selectedChipAnalisisIndex = 0;
                                    });
                                  }),
                              ),
                              const SizedBox(width: 4,),
                              SizedBox(
                                height: 40,
                                child: ChoiceChip(
                                  side: BorderSide.none,
                                  backgroundColor: const Color.fromARGB(255, 231, 230, 230),
                                  selectedColor: const Color.fromARGB(255, 250, 204, 204),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  label: const Text('Sebulan terakhir',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold
                                  ),), 
                                  selected: selectedChipAnalisisIndex == 1,
                                  onSelected: (bool value) {
                                    setState(() {
                                      selectedChipAnalisisIndex = 1;
                                    });
                                  }),
                              ),

                              const SizedBox(width: 4,),
                              SizedBox(
                                height: 40,
                                child: ChoiceChip(
                                  side: BorderSide.none,
                                  backgroundColor: const Color.fromARGB(255, 231, 230, 230),
                                  selectedColor: const Color.fromARGB(255, 250, 204, 204),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  label: const Text('Setahun terakhir',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold
                                  ),), 
                                  selected: selectedChipAnalisisIndex == 2,
                                  onSelected: (bool value) {
                                    setState(() {
                                      selectedChipAnalisisIndex = 2;
                                    });
                                  }),
                              ),

                              const SizedBox(width: 4,),
                              SizedBox(
                                height: 40,
                                child: ChoiceChip(
                                  side: BorderSide.none,
                                  backgroundColor: const Color.fromARGB(255, 231, 230, 230),
                                  selectedColor: const Color.fromARGB(255, 250, 204, 204),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  label: const Text('Semua Periode',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold
                                  ),), 
                                  selected: selectedChipAnalisisIndex == 3,
                                  onSelected: (bool value) {
                                    setState(() {
                                      selectedChipAnalisisIndex = 3;
                                    });
                                  }),
                              ),
                            ],
                          ),
                    ),

                    //TAMPILAN ANALISIS
                    const SizedBox(
                        height: 50,
                        width: 250,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 120,
                              height: 40,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Jumlah Laporan',
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 7,
                                    ),
                                  ),
                                  Text(
                                    '1609',
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                              height: 40,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: VerticalDivider(
                                      color: Colors.black,
                                      thickness: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              height: 40,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Keluhan Dominan',
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 7,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'Jalan Berlubang',
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    
                    //LIST LAPORAN PALING BAWAH
                    SizedBox(
                      width: 350,
                      child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/isilapor');
                          },
                          child: const HomeWidget(), 
                        );
                      },
                    ),
                    )

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Analisis {
  final String? periode;
  final String? hasil;
  Analisis({this.periode, this.hasil});
}

List<Analisis> userList = [
  Analisis(periode: "Sebulan terakhir", hasil: ""),
  Analisis(periode: "Duabulan terakhir ", hasil: ""),
  Analisis(periode: "Tigabulan terakhir ", hasil: ""),
  Analisis(periode: "Setahun terakhir ", hasil: ""),
];

