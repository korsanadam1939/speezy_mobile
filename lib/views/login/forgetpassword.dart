import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:speezy_mobile/widgets/speezy_button.dart';
import 'package:speezy_mobile/widgets/speezy_input.dart';

import '../../viewmodels/auth_viewmodel.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  var tfemail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(



        backgroundColor: Colors.white ,

        title: Text("Şifreyi sıfırla",style: TextStyle(color: Colors.black,fontSize: 24),),
        centerTitle: true,
      ),
      body:Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(

            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SpeezyInput(label: "Mail adresinizi giriniz",hintText: "E-posta",controller:tfemail ,),
              ),
              SpeezyButton(text: "kodu gönder",color: Colors.indigoAccent, onPressed: ()  {
               forgetpassword();

              })
            ],
          ),
        ),
      )

    );
  }

  Future<void> forgetpassword() async{


    bool durum=await Provider.of<AuthViewModel>(context, listen: false).sendcode(email: tfemail.text);




    if(durum==true){
      context.go("/resetpassword");
    }
    else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,

            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error,color: Colors.redAccent,size: 100,),
                Text("Bilinmeyen eposta formatı")
              ],
            ),

            actions: [
              TextButton(
                child: Center(child: Text("Tamam")),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

    }


  }
}
