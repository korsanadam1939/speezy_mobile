import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:speezy_mobile/widgets/speezy_button.dart';
import 'package:speezy_mobile/widgets/speezy_input.dart';

import '../../viewmodels/auth_viewmodel.dart';
import '../../widgets/Alertdialog.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset('assets/images/mim.jpg', fit: BoxFit.cover),

          // Overlay color (optional)
          Container(color: Colors.black.withOpacity(0.3)),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Giriş  yap",
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(
                        color: Colors.blue.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const _LoginForm(),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        context.push("/forgetpossword");
                      },
                      child: const Text('Şifrenimi unuttun?'),
                    ),
                    const Divider(),
                    TextButton(
                      onPressed: () {
                        context.go("/register");
                      },
                      child: const Text("Hesabinmi yok? Kaydol"),
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

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  var tfeposta = TextEditingController();
  var tfsifre = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  void _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      await login();
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          SpeezyInput(controller: tfsifre,obscureText: true,hintText: "Şifrenizi giriniz",validator: (value) {
            if (value == null || value.isEmpty) return 'Şifre boş';
            if (value.length < 6) return 'Minimum 6 karekter';
            return null;
          },),
          const SizedBox(height: 16),
          SpeezyButton(text: "Giriş yap", onPressed: (){
            _submit();
          },isLoading: viewModel.isLoading,color: Colors.indigoAccent,)
        ],
      ),
    );
  }
  Future<void> login() async {
    bool islogin = await Provider.of<AuthViewModel>(
      context,
      listen: false,
    ).login(context: context, email: tfeposta.text, password: tfsifre.text);
    print(islogin);
    if (islogin) {
      context.go("/bottom");
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            title: 'hata',
            icon: Icons.error,
            content: "Geçersiz kimlik bilgileri",
            onConfirm: () {
              context.pop();
            },
            onCancel: () {
              context.pop();
            },
          );
        },
      );
    }
  }
}
