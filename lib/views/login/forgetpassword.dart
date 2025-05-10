import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:speezy_mobile/widgets/speezy_button.dart';
import 'package:speezy_mobile/widgets/speezy_input.dart';

import '../../viewmodels/auth_viewmodel.dart';


class ForgetPasswordScreen extends StatelessWidget {

  const ForgetPasswordScreen({super.key});

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
                    BoxShadow(color: Colors.blue, blurRadius: 5, offset: Offset(0, 3))
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Şifreyi sifirla',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        )),
                    const SizedBox(height: 16),
                    const _ForgotPasswordForm(),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ForgotPasswordForm extends StatefulWidget {
  const _ForgotPasswordForm();

  @override
  State<_ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<_ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  var tfemail = TextEditingController();

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      sendCode();
      print('Reset email sent to: ${tfemail.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SpeezyInput(label :"E-postanızı giriniz",controller :tfemail ,hintText: "E-postanızı giriniz",validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email boş olamaz';
            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
              return 'Geçerli bir eposta gir';
            }
            return null;
          },),

          const SizedBox(height: 16),
          SpeezyButton(text: "kodu gönder", onPressed: (){
            _submit();
          },isLoading: viewModel.isLoading,color: Colors.indigoAccent,)
        ],
      ),
    );
  }

  Future<void> sendCode() async{


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