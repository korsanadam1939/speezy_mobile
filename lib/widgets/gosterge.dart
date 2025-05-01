import 'package:flutter/material.dart';

class Gosterge extends StatelessWidget {
  final String title;
  double progressValue;
  double ovallik = 10;
  double height;


  Gosterge({required this.title, required this.progressValue,required this.ovallik,required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ovallik), // Oval kenarlar
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
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text("Merhaba $title",style: TextStyle(fontSize: 18),),
            ),
            Padding(

              padding: const EdgeInsets.only(bottom: 5),
              child: LinearProgressIndicator(
                value: progressValue,
                backgroundColor: Colors.grey[300],
                color: Colors.blue,
                minHeight: 10,
              ),
            ),
            Text("10/200 Kelime öğrenildi")
          ],
        ),
      ),
    );
  }
}
