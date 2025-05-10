import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';
import '../../widgets/speezy_button.dart';
import '../../widgets/speezy_input.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                      'Kayit ol',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(
                        color: Colors.blue.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const _RegisterForm(),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        context.go("/login");
                      },
                      child: const Text('Zaten bir hesabin mi var? Giriş'),
                    ),
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

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  var tfeposta = TextEditingController();
  var tfusername = TextEditingController();
  var tfsifre = TextEditingController();

  void _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      await register();
      print('Email: ${tfeposta.text}');
      print('Password: ${tfsifre.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SpeezyInput(label :"E-postanızı giriniz",controller :tfeposta ,hintText: "E-postanızı giriniz",validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email boş olamaz';
            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
              return 'Geçerli bir eposta gir';
            }
            return null;
          },),

          const SizedBox(height: 12),
          SpeezyInput(controller: tfusername,hintText: "Kullanıcı adı",validator: (value) {
            if (value == null || value.isEmpty) return 'kullanıcı adı boş kalamaz';
            if (value.length < 6) return 'Minimum 6 karekter';
            return null;
          },),
          const SizedBox(height: 12),
          SpeezyInput(controller: tfsifre,obscureText: true,hintText: "Şifrenizi giriniz",validator: (value) {
            if (value == null || value.isEmpty) return 'Şifre boş';
            if (value.length < 6) return 'Minimum 6 karekter';
            return null;
          },),
          const SizedBox(height: 16),
          SpeezyButton(text: "Kayıt ol", onPressed: (){
            _submit();
          },isLoading: viewModel.isLoading,color: Colors.indigoAccent,)
        ],
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
