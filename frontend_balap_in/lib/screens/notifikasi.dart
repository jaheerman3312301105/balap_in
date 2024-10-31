import 'package:balap_in/widgets/notifikasiwidget.dart';
import 'package:flutter/material.dart';


class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();

}

class _NotificationsScreenState extends State<NotificationsScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
             Navigator.of(context).pop();
          }, 
          icon: const Icon(Icons.keyboard_arrow_left),
          color: const Color.fromRGBO(5, 5, 5, 0.612),
          iconSize: 40,),
          title: const Row(
          children: [
            Text('Pemberitahuan',
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
              ]
            ),
            ),
          ],
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

          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.87,
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  List<Color> colors = [
                            const Color.fromARGB(255, 253, 36, 36),
                            const Color.fromARGB(255, 36, 253, 36),
                            const Color.fromARGB(255, 249, 253, 36),
                            const Color.fromARGB(255, 249, 253, 36),
                            const Color.fromARGB(255, 253, 36, 36),
                            const Color.fromARGB(255, 36, 253, 36),
                          ];
        
                          Color bgColor = colors[index % colors.length];
                  return InkWell(
                   onTap: () {
                     Navigator.pushNamed(context, '/isirekomendasi');
                   },
                   child: WidgetNotification(colorWidget: bgColor),
                  );
                }
                ),
            )
          )
        ],
      ),

    );
  }
}