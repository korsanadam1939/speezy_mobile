import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:speezy_mobile/models/eror_model.dart';

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
  late bool errorMail =false ;
  late bool errorPassword=false ;
  late bool errorusername=false ;


  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool buttonactive = true;
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);
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
                child: SpeezyInput(label:"E-mail ",hintText: "E-mail",controller: tfeposta,onChanged: (value){
                  if(value.isEmpty){
                    setState(() {
                      errorMail = true;
                    });
                  }
                  else if(value.isNotEmpty){
                    if(errorMail ==true){
                      setState(() {
                        errorMail =false;
                      });

                    }

                  }
                },error: "Mail boş bırakılamaz",erorControl: errorMail),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SpeezyInput(label:"kullanıcı adı ",hintText: "Kullanıcı adı",controller: tfusername,onChanged: (value){
                  if(value.isEmpty){
                    setState(() {
                      errorusername = true;
                    });
                  }
                  else if(value.isNotEmpty){
                    if(errorusername ==true){
                      setState(() {
                        errorusername =false;
                      });

                    }

                  }
                },error: "kullanıcı adı boş bırakılamaz",erorControl: errorusername),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SpeezyInput(label: "şifrenizi gir",hintText: "Şifre",controller: tfsifre,obscureText: true,onChanged: (value){
                  if(value.isEmpty){
                    setState(() {
                      errorPassword = true;
                    });
                  }
                  else if(value.isNotEmpty){
                    if(errorPassword ==true){
                      setState(() {
                        errorPassword =false;
                      });

                    }

                  }
                },error: "Şifre 5 ile 15 haneli olmalıdır",erorControl: errorPassword),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SpeezyButton(text: "Kayıt ol",color: Colors.indigoAccent, onPressed: () async{
                  await register();




                },isLoading: viewModel.isLoading),
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

      var errorMesage =await Provider.of<AuthViewModel>(context, listen: false).register(username: tfusername.text, email: tfeposta.text, password: tfsifre.text);


      print(errorMesage?.message);

      if (errorMesage?.message == null) {
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
      else if(errorMesage?.message !=null){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,

              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error,color: Colors.redAccent,size: 100,),
                  Text(errorMesage?.message ??"hata")
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
