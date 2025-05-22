import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speezy_mobile/widgets/gosterge.dart';



class Gamescreen extends StatefulWidget {
  const Gamescreen({super.key});

  @override
  State<Gamescreen> createState() => _GamescreenState();
}

class _GamescreenState extends State<Gamescreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double progressValue = 0.2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Oyna",style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),),
        centerTitle: true,


      ),
      backgroundColor: Colors.white,
      //bottomNavigationBar: const MyBottomNavBar(currentIndex: 2),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15 ,right: 15,left: 15),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(
                  'assets/images/read.png',

                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15,right: 15,left: 15),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(
                  'assets/images/wordgameimage.png',

                  fit: BoxFit.cover,
                ),
              ),
            ),
          )




        ],
      )


    );
  }
}
