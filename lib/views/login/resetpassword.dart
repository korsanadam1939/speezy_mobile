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
  late bool errorCode = false;
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);

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
                  child: SpeezyInput(label: "mailinize gelen kodu giriniz",hintText: "Mailine gelen 4 haneli kodu gir",controller: tfcode,onChanged: (value){
                    if(value.length !=6 ){
                      setState(() {
                        errorCode = true;
                      });
                    }
                    else if(value.length == 6){
                      if(errorCode ==true){
                        setState(() {
                          errorCode =false;
                        });

                      }

                    }
                  },error: "Şifre boş bırakılamaz",erorControl: errorCode,),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SpeezyInput(label: "mailinize gelen kodu giriniz",hintText: "Yeni şifre",obscureText: true,controller: tfpassword,),
                ),
                SpeezyButton(text: "Şifreyi değiştir",color: Colors.indigoAccent, onPressed: (){
                  changepassword();
                },isLoading: viewModel.isLoading,)
              ],
            ),
          ),
        )

    );
  }
  Future<void> changepassword() async{

    if(tfmail.text.isNotEmpty && tfcode.text.length == 6 && tfpassword.text.isNotEmpty){

      bool isChange =await Provider.of<AuthViewModel>(context, listen: false).changethepassword(email: tfmail.text, code: tfcode.text, password: tfpassword.text);


      print(isChange);

      if (isChange == true) {
        print("kullanıcı başarıyla kaydedildi");

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,

              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Iconsax.tick_circle,color: Colors.greenAccent,size: 100,),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text("Şifre başarılıyla değiştirildi!"),
                  )
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
      else if(isChange == false){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,

              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error,color: Colors.redAccent,size: 100,),
                  Text("kod yanlış")
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
