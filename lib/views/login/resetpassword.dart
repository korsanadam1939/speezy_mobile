import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';
import '../../widgets/speezy_button.dart';
import '../../widgets/speezy_input.dart';

class ResetPasswordScreen extends StatelessWidget {

  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/mim.jpg', fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.3)),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.blue,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'KODU GIR',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(
                        color: Colors.blue.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const _ChangePasswodForm(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChangePasswodForm extends StatefulWidget {
  const _ChangePasswodForm();

  @override
  State<_ChangePasswodForm> createState() => _ChangePasswodFormState();
}

class _ChangePasswodFormState extends State<_ChangePasswodForm> {
  final _formKey = GlobalKey<FormState>();
  var tfmail = TextEditingController();
  var tfcode = TextEditingController();
  var tfpassword = TextEditingController();

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      changepassword();
      print('E-posta: ${tfmail.text}');
      print('Şifre: ${tfcode.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SpeezyInput(label :"E-postanızı giriniz",controller :tfmail ,hintText: "E-postanızı giriniz",validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email boş olamaz';
            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
              return 'Geçerli bir eposta gir';
            }
            return null;
          },),
          const SizedBox(height: 12),
          SpeezyInput(controller: tfcode,hintText: "Kodunuzu giriniz",validator: (value) {
            if (value == null || value.isEmpty) return 'Kodda boşluk olamaz';
            if (value.length != 6) return 'kod 6 haneli olmalı';
            return null;
          },),
          const SizedBox(height: 12),
          SpeezyInput(controller: tfpassword,obscureText: true,hintText: "Şifrenizi giriniz",validator: (value) {
            if (value == null || value.isEmpty) return 'Şifre boş';
            if (value.length < 6) return 'Minimum 6 karekter';
            return null;
          },),
          const SizedBox(height: 16),
          SpeezyButton(text: "Kayıt ol", onPressed: (){
            _submit();
          },isLoading: viewModel.isLoading,color: Colors.indigoAccent,),
        ],
      ),
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
