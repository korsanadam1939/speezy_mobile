import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speezy_mobile/services/auth_service.dart';
import 'package:speezy_mobile/views/login/register.dart';
import 'package:speezy_mobile/widgets/speezy_button.dart';
import 'package:speezy_mobile/widgets/speezy_input.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../services/shared_preferences_service.dart';
import '../../services/storage_service.dart';
import '../../viewmodels/auth_viewmodel.dart';



class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var tfeposta =TextEditingController();
  var tfsifre =TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(



        backgroundColor: Colors.white ,

        title: Text("Giriş yap",style: TextStyle(color: Colors.black,fontSize: 24),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(

            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //SizedBox(width:150,child: Image.asset("assets/images/fox.png")),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SpeezyInput(label:"E-mail ",hintText: "E-mail",controller: tfeposta,),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SpeezyInput(label: "şifrenizi gir",hintText: "Şifre",controller: tfsifre,obscureText: true,),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SpeezyButton(text: "Giriş yap",color: Colors.indigoAccent, onPressed: () async{
                  await login();



                }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(onPressed: (){
                    context.go("/register");


                  }, child: Text("Hesabınmı yok ?",style: TextStyle(color: Colors.indigoAccent),),),
                  TextButton(onPressed: (){
                    context.go("/forgetpossword");


                  }, child: Text("Şifrenimi unuttun ?",style: TextStyle(color: Colors.black),),)


                ],
              ),




            ],
          ),
        ),
      ),

    );
  }
  Future<void> login() async{


    String? token=await Provider.of<AuthViewModel>(context, listen: false).login(context:context,email: tfeposta.text,password: tfsifre.text);


    print(token);

    if(token != null){
      context.go("/bottom");


    }


  }


}

