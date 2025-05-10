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
        title: Text("Speezy",style: TextStyle(color: Colors.black,fontSize: 24),),
        centerTitle: true,


      ),
      backgroundColor: Colors.white,
      //bottomNavigationBar: const MyBottomNavBar(currentIndex: 2),

      body: Center(

        child: Text("oyun")
      ),


    );
  }
}
