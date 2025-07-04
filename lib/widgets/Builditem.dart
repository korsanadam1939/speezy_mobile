import 'package:flutter/material.dart';

class Builditem extends StatefulWidget {


  VoidCallback? onTap;

  IconData icon;
  String title;
  String subtitle;
  int progress;


  Builditem( this.icon, this.title, this.subtitle, this.progress,this.onTap);

  @override
  State<Builditem> createState() => _BuilditemState();
}

class _BuilditemState extends State<Builditem> {
  @override
  Widget build(BuildContext context) {

    return Opacity(
      opacity: 1,
      child: InkWell(
        onTap: widget.onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF8E2DE2),
                  Color(0xFF4A00E0 ),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),

              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(widget.icon, size: 40, color: Colors.white),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(widget.subtitle, style: TextStyle(color: Colors.white70)),
                          SizedBox(height: 15),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Progress",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '$widget.progress',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              LinearProgressIndicator(
                                value: widget.progress.toDouble(),
                                color: Colors.white,
                                backgroundColor: Colors.white24,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }

}
