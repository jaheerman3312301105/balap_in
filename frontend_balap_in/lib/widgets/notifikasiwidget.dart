import 'package:balap_in/api/api_service_notifikasi.dart';
import 'package:balap_in/models/model_notifikasi.dart';
import 'package:balap_in/shimmer/shimmernotification.dart';
import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';

class WidgetNotification extends StatefulWidget {

  const WidgetNotification({super.key});

  @override
  State<WidgetNotification> createState() => _WidgetNotificationState();
}

class _WidgetNotificationState extends State<WidgetNotification> {
  @override
  Widget build(BuildContext context) {
    final apiService = ApiServiceNotifikasi();
    return FutureBuilder <List<Notifikasi>>(
      future: apiService.fetchNotifikasi(), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Shimmernotification();
        } else if (snapshot.data!.length == 0) {
          return const Center(child: Text('Tidak ada Notifikasi terbaru'),);
        } else {
          List<Notifikasi> notifikasiList = snapshot.data!;

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: notifikasiList.length,
            itemBuilder: (context, index) {
              final notifikasi = notifikasiList[index];
              GetTimeAgo.setDefaultLocale('id');
              final waktu = DateTime.parse(notifikasi.tglnotif!).toLocal();
              final tgllapor = GetTimeAgo.parse(waktu);

              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context, '/isirekomendasi',
                        arguments: notifikasi.rekomendasi!.idrekomendasi);
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(1.0, 5.0),
                              blurRadius: 5.0, 
                              color: Colors.black26, 
                            )
                          ]
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 40,
                                left: 10,
                                right: 2
                                ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                                height: MediaQuery.of(context).size.height * 0.15,
                                child: Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 253, 36, 36),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  color: Color.fromARGB(218, 20, 20, 20),
                                  Icons.warning_rounded
                                ),
                                ),
                              ),
                            ),
                    
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 4,
                                bottom: 4,
                                left: 5,
                                ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.695,
                                height: MediaQuery.of(context).size.height * 0.13,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 4
                                        ),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.695,
                                        height: MediaQuery.of(context).size.height * 0.057,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${notifikasi.rekomendasi!.peta!.jalan} menjadi sorotan!',
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                    
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 1
                                        ),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.695,
                                        height: MediaQuery.of(context).size.height * 0.038,
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'Perubahan status pada ${notifikasi.rekomendasi!.peta!.jalan} menjadi prioritas tinggi, ayo pantau perkembangannya!',
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 8
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 1
                                        ),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.695,
                                        height: MediaQuery.of(context).size.height * 0.02,
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.access_time,
                                                size: 15,
                                                color: Colors.grey,
                                                ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 2
                                                  ),
                                                child: Text(
                                                  '${tgllapor}',
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 8
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                    
                                  ],
                                ),
                              ),
                            )
                    
                          ],
                        ),
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