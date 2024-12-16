import 'package:balap_in/api/api_service_rekomendasi.dart';
import 'package:balap_in/models/model_rekomendasi.dart';
import 'package:balap_in/screens/lapor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class RekomendasiWidget extends StatelessWidget {

  const RekomendasiWidget({super.key});

  
  @override
  Widget build(BuildContext context) {
    final apiService = ApiServiceRekomendasi();
    return FutureBuilder <List<Rekomendasi>>(
      future: apiService.fetchRekomendasi(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        } else if (snapshot.data!.length == 0) {
          return const Center(child: Text('Tidak ada rekomendasi'),);
        } else {
          List<Rekomendasi> rekomendasiList = snapshot.data!;

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: rekomendasiList.length,
            itemBuilder: (context, index) {
              final rekomendasi = rekomendasiList[index];
              final colorRekomendasi = rekomendasi.statusurgent;

              Color colorRekomendasis = Color.fromARGB(255, 250, 204, 204);

              if (colorRekomendasi == 'tinggi') {
                colorRekomendasis = const Color.fromARGB(255, 253, 36, 36);
              } else if (colorRekomendasi == 'sedang') {
                colorRekomendasis = const Color.fromARGB(255, 249, 253, 36);
              } else if (colorRekomendasi == 'rendah') {
                colorRekomendasis = const Color.fromARGB(255, 36, 253, 36);
              }

              String jenisconvert = '';


              if (rekomendasi.laporan!.jenis == 'jalan') {
                jenisconvert = "Jalan Rusak";
              }else if(rekomendasi.laporan!.jenis == 'lampu_jalan') {
                jenisconvert = "Lampu Jalan Rusak";
              }else if(rekomendasi.laporan!.jenis == 'jembatan') {
                jenisconvert = "Jembatan Rusak";
              }
              
              final idRekomendasi = rekomendasi.idrekomendasi;

              Color colorMarkerConvert = Colors.transparent;

              if (rekomendasi.statusurgent! == 'tinggi') {
                colorMarkerConvert = Colors.red;
              } else if (rekomendasi.statusurgent! == 'sedang') {
                colorMarkerConvert = Colors.yellow;
              } else if (rekomendasi.statusurgent! == 'rendah') {
                colorMarkerConvert = Colors.green;
              }

              return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context, '/isirekomendasi',
                      arguments: idRekomendasi
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.16,
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                      color: colorRekomendasis,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                          BoxShadow(
                          offset: Offset(1.0, 5.0),
                          blurRadius: 5.0, 
                          color: Colors.black26, 
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start, 
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.415,
                              margin: const EdgeInsets.only(
                                left: 10,
                                top: 15,
                              ),
                              child: Text(
                                rekomendasi.peta!.alamat,
                                style: const TextStyle(
                                  fontSize: 8,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.415,
                              margin: const EdgeInsets.only(
                                left: 10,
                                top: 5,
                              ),
                              child: Text(
                                jenisconvert,
                                style: const TextStyle(
                                  fontSize: 8,
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.415,
                              margin: const EdgeInsets.only(
                                left: 10,
                                top: 5,
                              ),
                              child: Row(
                                children: [
                                  const Image(
                                    image: AssetImage('assets/images/warningshield.png')
                                  ),
                                  const SizedBox(width: 2,),
                                  Text(
                                    '${rekomendasi.jumlahlaporan} Report',
                                    style: const TextStyle(
                                      fontSize: 8,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          child: Container(
                            margin: const EdgeInsets.only(
                              left: 1, 
                              right: 1
                              ),
                            height: MediaQuery.of(context).size.height * 0.14,
                            width: MediaQuery.of(context).size.width * 0.375,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: OSMViewer(
                                zoomOption: const ZoomOption(
                                  initZoom: 14,
                                  minZoomLevel: 10
                                ),
                                controller: SimpleMapController(
                                  initPosition: GeoPoint(
                                    latitude: rekomendasi.peta!.latitude, 
                                    longitude: rekomendasi.peta!.longitude), 
                                  markerHome: MarkerIcon(
                                    icon: Icon(Icons.location_on,
                                    size: MediaQuery.of(context).size.width * 0.068,
                                    shadows: const <Shadow>[
                                      Shadow(
                                        color: Colors.black,
                                        offset:Offset(4.0, 4.0),
                                        blurRadius: 4,
                                      )
                                    ],
                                    color: colorMarkerConvert),
                                  ),
                                  )
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              );
            }
          );
        }
      }
      );
  }
}
