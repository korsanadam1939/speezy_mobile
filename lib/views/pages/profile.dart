import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:speezy_mobile/widgets/Alertdialog.dart';
import 'package:speezy_mobile/widgets/speezy_button.dart';

import '../../viewmodels/auth_viewmodel.dart';

class Profile extends StatelessWidget {

  const Profile({super.key});


  @override
  Widget build(BuildContext context) {
    var tfurl =TextEditingController();
    final user = Provider.of<AuthViewModel>(context, listen: false).user;
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  "Profilim",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 62.5,
                    backgroundImage: NetworkImage(user?.profilePictureUrl ?? "https://media.tenor.com/_5QnkIqfcSkAAAAi/hi-hi-there.gif"),
          
                    backgroundColor:const Color(0xFFF6F8FF),
                  ),
                  Positioned(
                    child: GestureDetector(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Url yi gir'),
                              content: TextField(
                                controller: tfurl,
                                decoration: InputDecoration(hintText: "gif urlsi"),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Kapat
                                  },
                                  child: Text('İptal'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    print('Girilen metin: ${tfurl.text}');
                                    Provider.of<AuthViewModel>(context, listen: false).changeProfile(tfurl.text);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('ayarla'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.indigoAccent,
                        child: const Icon(Icons.edit, size: 16, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12),
              Text(
                user?.username ?? "isim yok",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                user?.email ?? "mail",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _StatCard(
                      icon: Iconsax.cup,
                      value: "34",
                      label: "Yapılan Görevler",
                      progress: 0.69, // %20 başlangıç
                    ),
                    _StatCard(
                      icon: Iconsax.award,
                      value: "150",
                      label: "Puan",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              _ProfileOption(icon: Icons.person, title: "Bilgilerim",onPressed: (){
                showModalBottomSheet(
                  backgroundColor: Colors.white70,
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: EdgeInsets.all(16),


                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Kullanıcı adı : ${user?.username}"),
                          Text("E-mail : ${user?.email}"),
                          Text("Level : ${user?.level}"),
                          Text("Rank : ${user?.rank}"),
                          Text("Total xp : ${user?.totalXp}"),
                          SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: SpeezyButton(text: "Kapat", onPressed: context.pop,color: Colors.indigoAccent,)
                          )
                        ],
                      ),
                    );
                  },
                );



              },),
              _ProfileOption(icon: Iconsax.moon, title: "Koyu mod",onPressed: (){

              }),
              _ProfileOption(icon: Icons.notifications, title: "Bildirimler",onPressed:(){

              },),
              _ProfileOption(icon: Icons.help, title: "Yardım",onPressed: (){

              },),
              TextButton(onPressed: (){
              }, child: Text("Çıkış yap",style: TextStyle(color: Colors.redAccent),))
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final double? progress;


  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final bool showProgress = progress != null;
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            if (showProgress)
              SizedBox(
                width: 36,
                height: 36,
                child: CircularProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey.shade300,
                  strokeWidth: 3,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.indigoAccent),
                ),
              ),
            Icon(icon, color: Colors.indigoAccent),
          ],
        ),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;

  const _ProfileOption({
    required this.icon,
    required this.title,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Icon(icon, color: Colors.indigoAccent),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onPressed,
        ),
      ),
    );
  }
}