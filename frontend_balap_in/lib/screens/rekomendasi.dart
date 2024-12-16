import 'package:balap_in/widgets/rekomendasiwidget.dart';
import 'package:flutter/material.dart';

bool showAdditionalChip = false;
bool filterSelected = false;

bool filterUrutkanSelected = false;
int selectedChipUrutkanIndex = 0;
class RecommendationsScreen extends StatefulWidget {
const RecommendationsScreen({super.key});

  @override
  _RecommendationsScreenState createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {

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
          title: const Text(
            'Area Urgensi',
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

         ListView(
            children: <Widget>[
              Center(
                child: Column(
                  children: [
                   // WIDGET 3 URUTKAN START
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //WIDGET URUTKAN BERDASARKAN START
                        SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  ),
                                child: SizedBox(
                                  width: 130,
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
                                            Image(
                                              image: AssetImage('assets/images/sort.png'),
                                            ),
                                            Text(
                                              'Urutkan Berdasarkan',
                                              style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10, 
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
                                ),
                              ),
                              //WIDGET URUTKAN BERDASARKAN END
        
                              //WIDGET URUTKAN TERTINGGI START
                              if (showAdditionalChip)
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 10
                                  ),
                                child: SizedBox(
                                    child: ChoiceChip(
                                      side: BorderSide.none,
                                      backgroundColor: const Color.fromARGB(255, 231, 230, 230),
                                      selectedColor: const Color.fromARGB(255, 250, 204, 204),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                      label: const Text('Tertinggi',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold
                                      ),), 
                                      selected: selectedChipUrutkanIndex == 0,
                                      onSelected: (bool value) {
                                        setState(() {
                                          selectedChipUrutkanIndex = 0;
                                        });
                                      }),
                                  ),
                              ),
                              //WIDGET URUTKAN TERTINGGI END
        
                              //WIDGET URUTKAN TERENDAH START
                              if (showAdditionalChip)
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 10
                                  ),
                                child: SizedBox(
                                    child: ChoiceChip(
                                      side: BorderSide.none,
                                      backgroundColor: const Color.fromARGB(255, 231, 230, 230),
                                      selectedColor: const Color.fromARGB(255, 250, 204, 204),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                      label: const Text('Terendah',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold
                                      ),), 
                                      selected: selectedChipUrutkanIndex == 1,
                                      onSelected: (bool value) {
                                        setState(() {
                                          selectedChipUrutkanIndex = 1;
                                        });
                                      }),
                                  ),
                              ),
                              //WIDGET URUTKAN TERENDAH END
                            ],
                          )
                          ),
                        ],
                    ),
                    //WIDGET 3 URUTKAN END
        
                    //WIDGET REKOMENDASI START
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.87,
                      child: const RekomendasiWidget()
                    )
                    //WIDGET REKOMENDASI END 
                  ],
                ),
              ),
        
        
            ],
          ),
        ]
      )
        

    );
  }
}