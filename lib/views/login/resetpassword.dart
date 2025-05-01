import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';
import '../../widgets/speezy_button.dart';
import '../../widgets/speezy_input.dart';

class Resetpassword extends StatefulWidget {
  const Resetpassword({super.key});

  @override
  State<Resetpassword> createState() => _ResetpasswordState();
}

class _ResetpasswordState extends State<Resetpassword> {

  var tfmail = TextEditingController();
  var tfcode = TextEditingController();
  var tfpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(



          backgroundColor: Colors.white ,

          title: Text("Kodu gir",style: TextStyle(color: Colors.black,fontSize: 24),),
          centerTitle: true,
        ),
        body:Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(

              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SpeezyInput(label: "mailinize gelen kodu giriniz",hintText: "E-posta",controller: tfmail,),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SpeezyInput(label: "mailinize gelen kodu giriniz",hintText: "Kod",controller: tfcode,),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SpeezyInput(label: "mailinize gelen kodu giriniz",hintText: "Yeni şifre",obscureText: true,controller: tfpassword,),
                ),
                SpeezyButton(text: "Şifreyi değiştir",color: Colors.indigoAccent, onPressed: (){
                  changepassword();
                })
              ],
            ),
          ),
        )

    );
  }
  Future<void> changepassword() async{
    if(tfmail.text.isNotEmpty && tfcode.text.isNotEmpty && tfpassword.text.isNotEmpty){

      Map<String?, dynamic>? yanit =await Provider.of<AuthViewModel>(context, listen: false).changethepassword(email: tfmail.text, code: tfcode.text, password: tfpassword.text);


      print(yanit?["durum"]);

      if (yanit?["durum"] == true) {
        print("kullanıcı başarıyla kaydedildi");

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,

              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Iconsax.tick_circle,color: Colors.redAccent,size: 100,),
                  Text("kullanıcı başarıyla kaydedildi")
                ],
              ),

              actions: [
                TextButton(
                  child: Center(child: Text("Tamam")),
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.go("/login");
                  },
                ),
              ],
            );
          },
        );
      }
      else if(yanit?["durum"] == false){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,

              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error,color: Colors.green,size: 100,),
                  Text(yanit?["error"])
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



    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Giriş hatalı")),
      );
      print("hata var");

    }




  }

}
