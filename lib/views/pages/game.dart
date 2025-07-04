import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:speezy_mobile/widgets/Builditem.dart';
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
        centerTitle: true ,


      ),
      backgroundColor: Colors.white,
      //bottomNavigationBar: const MyBottomNavBar(currentIndex: 2),

      body: Column(
        children: [
          Builditem( Icons.videogame_asset, "Role oyunu", "zor şartlarda ingilizce konuşmayı öğren", 60,(){
            context.push("/rolegame");
          }),
          Builditem( Icons.menu_book, "Hikaye Okuma", "Telafuzunu ve okuma akıçılığını geliştir", 60,(){
            context.push("/reading");
          })


        ],
      )


    );
  }
}
