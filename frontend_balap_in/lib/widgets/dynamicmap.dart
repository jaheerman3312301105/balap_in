import 'package:balap_in/api/api_service_rekomendasi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class Dynamicmap extends StatefulWidget {
  const Dynamicmap({super.key});

   @override
  _DynamicmapState createState() => _DynamicmapState();
}

class _DynamicmapState extends State<Dynamicmap> {
  late MapController controller;
  @override
  void initState() {
    super.initState();
    controller = MapController(
      // initMapWithUserPosition: const UserTrackingOption(
      //   enableTracking: true
      // )
      initPosition: GeoPoint(latitude: 1.10230, longitude: 104.03881),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await addInitialMarker();
    });
  }

  Future<void> addInitialMarker() async {
    ApiServiceRekomendasi apiService = ApiServiceRekomendasi();
    
    try {
      await controller.removeMarkers([]);
      final apiServiceList = await apiService.fetchRekomendasiBiasa();
    
      for (var item in apiServiceList) {
        double latitude = item.peta!.latitude;
        double longitude = item.peta!.longitude;
        String status = item.statusurgent!;

        Color colorRekomendasi = Colors.transparent;

        if (status == 'tinggi') {
          colorRekomendasi = const Color.fromARGB(255, 253, 36, 36);
        } else if (status == 'sedang') {
          colorRekomendasi = const Color.fromARGB(255, 249, 253, 36);
        } else if (status == 'rendah') {
          colorRekomendasi = const Color.fromARGB(255, 36, 253, 36);
        }
        
        await controller.addMarker(
        GeoPoint(
          latitude: latitude, 
          longitude: longitude
        ),
          markerIcon: MarkerIcon(
            icon: Icon(
              shadows: const <Shadow>[
                Shadow(
                  color: Colors.black,
                  offset:Offset(4.0, 4.0),
                  blurRadius: 4,
                )
              ],
              Icons.location_on,
              color: colorRekomendasi,
              size: 40,
            ),
          ),
          angle: 2,
          iconAnchor: IconAnchor(
            anchor: Anchor.center
          )
        );
      }
      
    } catch (e) {
      print('Gagal mendapatkan API: $e');
    }
  }
    

  @override
  Widget build(BuildContext context) {
      return Container(
              height: MediaQuery.of(context).size.height * 0.24,
              width: MediaQuery.of(context).size.width * 1,
              margin: const EdgeInsets.only(
                bottom: 10,
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
              child: Stack(
                children: [
                  

                  OSMFlutter(
                  controller: controller, 
                  osmOption: const OSMOption(
                    showZoomController: true,
                    zoomOption: ZoomOption(
                        initZoom: 15,
                        minZoomLevel: 9,
                        maxZoomLevel: 19,
                    )
                  ),
                  onMapIsReady: (isReady) async {
                  await addInitialMarker();
                  },),
                  
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), 
                          blurRadius: 4, 
                          offset: const Offset(5, 5), 
                          )
                        ],
                      color: const Color.fromARGB(155, 250, 204, 204),
                      borderRadius: BorderRadius.circular(100)
                      ),
                      child: IconButton(
                      color: Colors.black,
                      iconSize: 25,
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => const FullDynamicMap())
                          );
                      }, 
                      icon: const Icon(Icons.map)
                      ),
                    ),
                  )
                  ]
              )
    );
  }
}

class FullDynamicMap extends StatefulWidget {
  const FullDynamicMap({super.key});

  @override
  _FullDynamicMapState createState() => _FullDynamicMapState();
}

class _FullDynamicMapState extends State<FullDynamicMap> {
  late MapController controller;
  @override
  void initState() {
    super.initState();
    controller = MapController(
      // initMapWithUserPosition: const UserTrackingOption(
      //   enableTracking: true
      // )
      initPosition: GeoPoint(latitude: 1.10230, longitude: 104.03881),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await addInitialMarker();
    });
  }

  Future<void> addInitialMarker() async {
    ApiServiceRekomendasi apiService = ApiServiceRekomendasi();
    
    try {
      await controller.removeMarkers([]);
      final apiServiceList = await apiService.fetchRekomendasiBiasa();
    
      for (var item in apiServiceList) {
        double latitude = item.peta!.latitude;
        double longitude = item.peta!.longitude;
        String status = item.statusurgent!;

        Color colorRekomendasi = Colors.transparent;
        if (status == 'tinggi') {
          colorRekomendasi = const Color.fromARGB(255, 253, 36, 36);
        } else if (status == 'sedang') {
          colorRekomendasi = const Color.fromARGB(255, 249, 253, 36);
        } else if (status == 'rendah') {
          colorRekomendasi = const Color.fromARGB(255, 36, 253, 36);
        }
        
        await controller.addMarker(
        GeoPoint(
          latitude: latitude, 
          longitude: longitude
        ),
          markerIcon: MarkerIcon(
            icon: Icon(
              shadows: const <Shadow>[
                Shadow(
                  color: Colors.black,
                  offset:Offset(4.0, 4.0),
                  blurRadius: 4,
                )
              ],
              Icons.location_on,
              color: colorRekomendasi,
              size: 40,
            ),
          ),
          angle: 2,
          iconAnchor: IconAnchor(
            anchor: Anchor.center
          )
        );
      }
      
    } catch (e) {
      print('Gagal mendapatkan API: $e');
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark
        ),
        backgroundColor: Colors.transparent,
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
                  text: 'Peta Persebaran',
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
            top: -40,
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

          Padding(
            padding: EdgeInsets.only(
               top: MediaQuery.of(context).size.height * 0.097
              ),
            child: OSMFlutter(
            controller: controller, 
            osmOption: const OSMOption(
                      showZoomController: true,
                      zoomOption: ZoomOption(
                        initZoom: 15,
                        minZoomLevel: 9,
                        maxZoomLevel: 19,
                      )
                      ),
            onMapIsReady: (isReady) async {
              await addInitialMarker();
            },
                    ),
          ),
        ]
      ),
    );
  }

}