import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speezy_mobile/services/auth_service.dart';
import 'package:speezy_mobile/views/login/register.dart';
import 'package:speezy_mobile/widgets/Alertdialog.dart';
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
  late bool errorMail =false ;
  late bool errorPassword=false ;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override


  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);
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
                },error: "Mail boş bırakılamaz",erorControl: errorMail,),
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
                },error: "Şifre boş bırakılamaz",erorControl: errorPassword,),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SpeezyButton(isLoading: viewModel.isLoading,text: "Giriş yap",color: Colors.indigoAccent, onPressed: () async{
                  await login();



                },),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(onPressed: (){
                    context.go("/register");


                  }, child: Text("Hesabınmı yok ?",style: TextStyle(color: Colors.indigoAccent),),),
                  TextButton(onPressed: (){
                    context.push("/forgetpossword");


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


    bool islogin =await Provider.of<AuthViewModel>(context, listen: false).login(context:context,email: tfeposta.text,password: tfsifre.text);
    print(islogin);
    if(islogin){
      context.go("/bottom");
    }else{
      showDialog(context: context, builder: (BuildContext context){

        return CustomAlertDialog(title: 'hata',icon:Icons.error,content: "Geçersiz kimlik bilgileri", onConfirm: () {
          context.pop();
        }, onCancel: () {
          context.pop();
        },);

      });

    }



  }


}

