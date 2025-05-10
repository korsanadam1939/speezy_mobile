import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:speezy_mobile/widgets/gosterge.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double progressValue = 0.2;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.notifications_none),
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text("Speezy",style: TextStyle(color: Color(0xFF000080),fontSize: 24,fontWeight: FontWeight.w500),),
        ),
        centerTitle: true,


      ),
      backgroundColor: Colors.white,
      //bottomNavigationBar: const MyBottomNavBar(currentIndex: 2),

      body: Center(

        child: Padding(
          padding: const EdgeInsets.only(top: 15 ,right: 8,left: 8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(

              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Expanded(child: Gosterge(title: "Merhaba erdem", progressValue: 0.2, ovallik: 10,height: screenHeight/7.5,)),
                    ],
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: Container(

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10), // Oval kenarlar
                        border: Border.all(
                          color: Colors.indigoAccent, // Kenarlık rengi
                          width: 1.5,            // Kenarlık kalınlığı
                        ),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text("Görevler",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                ),
                              ],
                            ),
                            ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                ListTile(
                                  leading: Icon(Icons.star,color: Colors.yellow,),
                                  title: Text('Hikaye oku'),
                                  trailing: Text("10 XP"),

                                  onTap: () {
                                    print('Anasayfa tıklandı');
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.star,color: Colors.yellow,),
                                  title: Text('Ayarlar'),
                                  trailing: Text("10 XP"),
                                  onTap: () {
                                    print('Ayarlar tıklandı');
                                  },
                                ),
                              ],
                            )







                          ],
                        ),
                      ),
                              ),
                  ),
                ],
              )




              ],


            ),
          ),
        ),
      ),


    );
  }
}
