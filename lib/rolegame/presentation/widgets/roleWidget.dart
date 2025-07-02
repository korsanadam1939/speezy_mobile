import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speezy_mobile/widgets/speezy_button.dart';
import '../../business/entities/RoleEntity.dart';
import '../providers/role_provider.dart';
import '../../../core/errors/failure.dart';

class RoleWidget extends StatelessWidget {
  OverlayEntry? _overlayEntry;



  @override
  Widget build(BuildContext context) {
    RoleEntity? role = Provider.of<RoleProvider>(context).role;
    Failure? failure = Provider.of<RoleProvider>(context).failure;




    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
        child: Column(
          children: [
            if (role != null) ...[

              Column(
                children: [
                  Text(role.title),
                  Text(role.senorio),
                  TextField(decoration: InputDecoration(
                    hintText: "Bu durumda ne yaparsın (ingilizce yaz)"
                  ),),
                  SpeezyButton(text: "Yeniden üret", onPressed: (){
                    Provider.of<RoleProvider>(context, listen: false).eitherFailureOrRole();
                  })

                ],
              )


            ] else if (failure != null) ...[
              Expanded(
                child: Center(
                  child: Text(
                    failure.errorMessage,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ] else ...[
              const Expanded(
                child: Center(
                  child:  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.cyanAccent),
                    strokeWidth: 8,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
  Future<String> getword(Map<String,String> words,String wordinput) async {
    for (var word in words.entries) {
      print("${word.key} : ${word.value}");
      if(word.key ==wordinput ){
        return word.value;

      }

    }
    return "kelime yok";

}
  void _showOverlay(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 100,
        left: 50,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.black87,
            child: const Text(
              'Bu bir overlay!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );


    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

}
