import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';


import '../viewmodels/auth_viewmodel.dart';
import '../widgets/bottombor.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {

    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      //bottomNavigationBar: const MyBottomNavBar(currentIndex: 2),

      body: Center(

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Iconsax.profile_circle,size: 100,),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(authViewModel.user?.username ?? "",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Container(
                                width: 50,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Colors.white10,
                                  border: Border.all(
                                    color: Colors.indigoAccent,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(35), // oval kenarlar
                                ),
                                child: Center(
                                  child: Text(
                                    authViewModel.user!.level!,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),

                              ),
                            ),
                            Container(
                              width: 75,
                              height: 25,
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                border: Border.all(
                                  color: Colors.indigoAccent,
                                  width:1.5,
                                ),
                                borderRadius: BorderRadius.circular(35), // oval kenarlar
                              ),
                              child: Center(
                                child: Text(
                                  authViewModel.user?.rank ?? "",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),

                            ),


                          ],
                        )

                      ],
                    )
                  ],
                ),
                GestureDetector(
                    onTap: (){
                      Provider.of<AuthViewModel>(context, listen: false).logout();
                      context.go("/login");
                    },
                    child: Text("Çıkış yap",style: TextStyle(color: Colors.redAccent),))

              ],


            ),
          ),
        ),
      ),

    );
  }
}
