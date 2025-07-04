import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:speezy_mobile/roleanswer/presentation/providers/answer_provider.dart';
import 'package:speezy_mobile/roleanswer/presentation/widgets/answerWidget.dart';
import 'package:speezy_mobile/widgets/Alertdialog.dart';
import 'package:speezy_mobile/widgets/Loading_widget.dart';

import '../../../core/errors/failure.dart';
import '../../business/entities/RoleEntity.dart';
import '../providers/role_provider.dart';

// --- Constants ---
class AppColors {
  static const Color primaryOrange = Color(0xFFFFA000);
  static const Color lightOrange = Color(0xFFFFCC80);
  static const Color gradientStartGreen = Color(0xFF4CAF50);
  static const Color gradientEndGreen = Color(0xFF1B5E20);
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color blueAccent = Color(0xFF42A5F5);
  static const Color cardBackground = Colors.white;
  static const Color textColor = Colors.black87;
  static const Color hintColor = Colors.grey;
  static const Color iconColor = Colors.grey;
  static const Color heartColor = Colors.red;
}

class AppStrings {
  static const String appTitle = 'Rol Yapma';
  static const String improveSpeakingSkills =
      'İngilizce konuşma becerilerini geliştir';
  static const String restaurantWaiter = 'Restoran Garsonı';
  static const String scenarioDescription =
      'Bir müşteri olarak restorana geldiniz ve sipariş vermek istiyorsunuz. Garsonla konuşun.';
  static const String speakWithCharacter = 'Senaryo karakterin ile konuş!';
  static const String writeAnswerInEnglish = 'Cevabını İngilizce yaz:';
  static const String exampleAnswer =
      'Örnek: Hello! I would like to order some food please...';
  static const String generateNewRole = 'Yeni Rol Üret';
  static const String tips = 'İpuçları';
  static const String tip1 = 'Selamlaşmayı unutma (Hello, Good morning, etc.)';
  static const String tip2 = 'Nezaket kelimelerini kullan (Please, Thank you)';
  static const String tip3 = 'Tam cümleler kurmaya çalış';
  static const String tip4 = 'Senaryoya uygun kelimeler seç';
}

class OrangeCard extends StatelessWidget {
  String senorio;
  String title;
  String roleemoji;
  String titleemoji;
  Map<String,String> translations;


  OrangeCard({required this.senorio,  required this.title, required this.titleemoji, required this.translations,required this.roleemoji});

  @override
  Widget build(BuildContext context) {
    RoleEntity? role = Provider.of<RoleProvider>(context).role;
    Failure? failure = Provider.of<RoleProvider>(context).failure;


    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryOrange, AppColors.lightOrange],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [



            SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child: Row(
                children: [

                  const SizedBox(width: 8.0),
                  Text(
                    "$titleemoji $title",
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            RichText(
              text: TextSpan(
                children: senorio
                    .split(' ')
                    .map((kelime) => TextSpan(
                  text: '$kelime ',
                  style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {

                      String wordmean = await getword(translations, kelime.toLowerCase().replaceAll(RegExp(r'[.,!?"]'), ''));
                      print("kelimenin anlamı $wordmean ");
                      showDialog(
                        context: context,
                        builder:
                            (_) => AlertDialog(
                          title: Center(child: Text("Kelime çevirisi")),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                kelime.replaceAll(RegExp(r'[.,!?"]'), '' ),style: TextStyle(fontSize: 20,color: Colors.red, fontWeight: FontWeight.bold),
                              ),
                              Text('    -    '),
                              Text(
                                wordmean,style: TextStyle(fontSize: 20,color: Colors.blueGrey, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          actions: [
                            Center(
                              child: SizedBox(
                                width: 200,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  label: const Text(
                                    'Kapat',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );




                    },
                ))
                    .toList(),
              ),
            )



        ],
      ),
    );
  }
  Future<String> getword(Map<String,String> words,String wordinput) async {
    for (var word in words.entries) {
      print("${word.key} : ${word.value}");
      if(word.key.toLowerCase() ==wordinput.toLowerCase() ){
        return word.value;

      }

    }
    return "kelime yok";

  }
}

class MesajCard extends StatelessWidget {
  String roleemoji;
  String yourtask;
  TextEditingController tfanswer;
  final VoidCallback onPressed;


   MesajCard(this.roleemoji,this.yourtask,this.tfanswer,this.onPressed);

   @override
  Widget build(BuildContext context) {


    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              yourtask,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16.0),
          Center(
            child: Text(roleemoji),
          ),
          const SizedBox(height: 20.0),
          Text(
            AppStrings.writeAnswerInEnglish,
            style: TextStyle(fontSize: 14.0, color: AppColors.textColor),
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: AppColors.grey.withOpacity(0.3)),
            ),
            child: TextField(
              controller: tfanswer,
              decoration: InputDecoration(
                hintText: AppStrings.exampleAnswer,
                hintStyle: TextStyle(color: AppColors.hintColor),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send, color: AppColors.blueAccent),
                  onPressed: onPressed
                ),
              ),
              maxLines: null,
              minLines: 1,
              keyboardType: TextInputType.multiline,
            ),
          ),
        ],
      ),
    );
  }
}

class Ipuclari extends StatelessWidget {
  const Ipuclari({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.favorite, color: AppColors.heartColor),
              const SizedBox(width: 8.0),
              Text(
                AppStrings.tips,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          _buildTipItem(AppStrings.tip1),
          _buildTipItem(AppStrings.tip2),
          _buildTipItem(AppStrings.tip3),
          _buildTipItem(AppStrings.tip4),
        ],
      ),
    );
  }

  Widget _buildTipItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.circle, size: 8.0, color: AppColors.blueAccent),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14.0, color: AppColors.textColor),
            ),
          ),
        ],
      ),
    );
  }
}

class YeniRolButon extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  const YeniRolButon({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppColors.gradientStartGreen,
                AppColors.gradientEndGreen,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            constraints: const BoxConstraints(minHeight: 50.0),
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: AppColors.white),
                  const SizedBox(width: 8.0),
                ],
                Text(
                  text,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class RolePage extends StatefulWidget {
  const RolePage({super.key});

  @override
  State<RolePage> createState() => _RolePageState();
}

class _RolePageState extends State<RolePage> {
  var tfanswer = TextEditingController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      Provider.of<RoleProvider>(context, listen: false).eitherFailureOrRole();
    });

  }
  @override
  Widget build(BuildContext context) {
    RoleEntity? role = Provider.of<RoleProvider>(context).role;
    Failure? failure = Provider.of<RoleProvider>(context).failure;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              AppStrings.appTitle,
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              AppStrings.improveSpeakingSkills,
              style: TextStyle(color: AppColors.grey, fontSize: 14.0),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              if(role != null) ...[
                OrangeCard(title: role!.title,senorio: role.senorio,titleemoji: role.title_emoji,roleemoji: role.role_emoji,translations: role.translations,),
                // Avatar and "Senaryo karakterin ile konuş!" text (Image is part of MesajCard now)
                // The image in the provided designs is between the scenario card and the input field.
                // I'll place it inside the MesajCard for better encapsulation as it relates directly to the chat.
                MesajCard(role.role_emoji,role.your_task,tfanswer,(){
                  print("basıldı");
                  Future.microtask(() {
                    Provider.of<AnswerProvider>(context, listen: false).eitherFailureOrAnswer(tfanswer.text);
                  });

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: SingleChildScrollView(child: AnswerWidget(tfanswer.text)),
                      actions: [

                        TextButton(
                          child: Text('Tamam'),
                          onPressed: () {
                            Navigator.of(context).pop();

                          },
                        ),
                      ],
                    ),
                  );


                }),
                YeniRolButon(
                  text: AppStrings.generateNewRole,
                  icon: Icons.refresh, // Using refresh icon for "Yeni Rol Üret"
                  onPressed: () {
                    // Logic for generating a new role
                    print('Yeni Rol Üret button pressed!');
                    print(role.your_task);
                    Future.microtask(() {
                      Provider.of<RoleProvider>(context, listen: false).eitherFailureOrRole();
                    });


                  },
                ),
                const Ipuclari(),
                const SizedBox(height: 20.0),
              ] else if(failure != null) ...[
                Text("hata")

              ] else ...[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Center(
                    child: LoadingWidget(),
                  ),
                ),

              ]



            ],
          ),
        ),
      ),
    );
  }

}


