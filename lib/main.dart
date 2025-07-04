import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:speezy_mobile/providers/theme_provider.dart';
import 'package:speezy_mobile/reading/presentation/providers/reading_provider.dart';
import 'package:speezy_mobile/roleanswer/presentation/providers/answer_provider.dart';
import 'package:speezy_mobile/rolegame/presentation/providers/role_provider.dart';
import 'package:speezy_mobile/services/auth_service.dart';
import 'package:speezy_mobile/services/shared_preferences_service.dart';
import 'package:speezy_mobile/services/storage_service.dart';
import 'package:speezy_mobile/wordgame/presentation/providers/word_provider.dart';
import 'routes/app_router.dart';
import 'viewmodels/auth_viewmodel.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // EasyLocalization başlatma
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      child: MyApp(),
      supportedLocales: const [
        Locale('tr', ''),
        Locale('en', ''),
      ],
      fallbackLocale: const Locale('en', ''),
      path: 'assets/langs',
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SharedPreferencesService()),
        ChangeNotifierProvider(create: (_) => ReadingProvider()),

        ChangeNotifierProvider(create: (_) => RoleProvider()),
        ChangeNotifierProvider(create: (_) => AnswerProvider()),

        ChangeNotifierProvider(
          create: (context) {
            final storageService = Provider.of<StorageService>(context, listen: false);
            return AuthViewModel(
              storageService,
              AuthService(storageService),
            );
          },
        ),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Builder(
        builder: (context) {
          final authViewModel = Provider.of<AuthViewModel>(
            context,
            listen: false,
          );
          final themeProvider = Provider.of<ThemeProvider>(
            context,
          );
          final router = createRouter(authViewModel);

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Speezy App',
            theme: themeProvider.themeData,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
