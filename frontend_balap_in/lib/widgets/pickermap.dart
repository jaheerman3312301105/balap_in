import 'package:balap_in/api/api_service_mappicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class WidgetMapPicker extends StatefulWidget {
  final Function(GeoPoint) onLocationPicked;
  const WidgetMapPicker({
    Key? key,
    required this.onLocationPicked,
  }) : super(key: key);


  @override
  WidgetMapPickerState createState() => WidgetMapPickerState();
}

  ApiServiceMappicker getGeo = ApiServiceMappicker();
  
class WidgetMapPickerState extends State<WidgetMapPicker> {

  GeoPoint? pickedLocation;
  
    PickerMapController controllerMap = PickerMapController(
      initPosition: GeoPoint(
        latitude: 1.10329, 
        longitude: 104.03512),
      
      // initMapWithUserPosition: const UserTrackingOption(
      //   enableTracking: true,
      //   unFollowUser: true
      // ),
    );

    @override
    void dispose() {
      controllerMap.dispose();
      super.dispose();
    }

    Future<void> mapPicker() async{
      showDialog(
        barrierDismissible: true,
        context: context, 
        builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.85,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CustomPickerLocation(
                showDefaultMarkerPickWidget: true,
                controller: controllerMap,
                  appBarPicker: AppBar(
                  backgroundColor: const Color.fromARGB(255, 250, 204, 204),
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  toolbarHeight: 40,
                  title: const Text('Pilih Lokasi',
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),),
                ),
                bottomWidgetPicker: SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 1,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20,
                      ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                height: MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: const Offset(2, 5),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(100),
                                  color: const Color.fromARGB(255, 196, 196, 196),
                                ),
                                child: const Center(child: Text(
                                  'Batal',
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold
                                  ),
                                  ),),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                final geoPoint = await controllerMap.selectAdvancedPositionPicker();
                                pickedLocation = geoPoint;
                                widget.onLocationPicked(geoPoint); 
                                setState(() {
                                  // print(pickedLocation);
                                  if (pickedLocation != null) {
                                    Navigator.pop(context);
                                  }
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                height: MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: const Offset(2, 5),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(100),
                                  color: const Color.fromARGB(255, 250, 204, 204),
                                  
                                ),
                                child: const Center(child: Text('Pilih',
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold
                                ),)),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                pickerConfig: const CustomPickerLocationConfig(
                  zoomOption: ZoomOption(
                    initZoom: 15,
                    stepZoom: 11
                    ),
                  ),
               ),
            )
        ),
      );
    });   
  }

            Widget build(BuildContext context) {
            return SizedBox(
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
                              onTap: () {
                                mapPicker();
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
                                        'Alamat',
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
                      );
  }
}