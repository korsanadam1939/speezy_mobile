import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';
import '../../widgets/speezy_button.dart';
import '../../widgets/speezy_input.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var tfeposta =TextEditingController();
  var tfusername =TextEditingController();
  var tfsifre =TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(


        backgroundColor: Colors.white ,
        centerTitle: true,

        title: Text("Kayıt ol",style: TextStyle(color: Colors.black,fontSize: 24),),
      ),
      body: Center(

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(

            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SpeezyInput(label:"E-mail ",hintText: "E-mail",controller: tfeposta,),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SpeezyInput(label:"kullanıcı adı ",hintText: "Kullanıcı adı",controller: tfusername,),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SpeezyInput(label: "şifrenizi gir",hintText: "Şifre",controller: tfsifre,obscureText: true,),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SpeezyButton(text: "Kayıt ol",color: Colors.indigoAccent, onPressed: () async{
                  await register();




                }),
              ),

              TextButton(onPressed: (){
                context.go("/login");

              }, child: Text("Zaten bir hesabınmı var ?",style: TextStyle(color: Colors.black),)),





            ],
          ),
        ),
      ),

    );


  }
  Future<void> register() async{
    if(tfusername.text.isNotEmpty && tfeposta.text.isNotEmpty && tfsifre.text.isNotEmpty){

      Map<String?, dynamic>? yanit =await Provider.of<AuthViewModel>(context, listen: false).register(username: tfusername.text, email: tfeposta.text, password: tfsifre.text);


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
                  Icon(Iconsax.tick_circle,color: Colors.green,size: 100,),
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
                  Icon(Icons.error,color: Colors.redAccent,size: 100,),
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
