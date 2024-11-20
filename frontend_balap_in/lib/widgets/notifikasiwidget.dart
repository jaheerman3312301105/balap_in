import 'package:flutter/material.dart';

class WidgetNotification extends StatefulWidget {
  final Color colorWidget;

  const WidgetNotification({super.key, required this.colorWidget});

  @override
  State<WidgetNotification> createState() => _WidgetNotificationState();
}

class _WidgetNotificationState extends State<WidgetNotification> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
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
                    decoration: BoxDecoration(
                      color: widget.colorWidget,
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
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Jalan bandara hangnadim menjadi sorotan!',
                                style: TextStyle(
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
                            child: const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Perubahan status pada jalan bandara hangnadim menjadi prioritas tinggi, ayo pantau perkembangannya!',
                                style: TextStyle(
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
                            child: const Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 15,
                                    color: Colors.grey,
                                    ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 2
                                      ),
                                    child: Text(
                                      '1 hari yang lalu',
                                      style: TextStyle(
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
    );
  }
}