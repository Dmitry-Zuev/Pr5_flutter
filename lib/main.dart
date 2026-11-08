import 'package:flutter/material.dart';

import 'data/framework_data.dart';
import 'models/user_profile_data.dart';
import 'pages/detail_page.dart';
import 'pages/home_page.dart';
import 'pages/loading_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Кроссплатформенные фреймворки',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
      ),
      initialRoute: Routes.loading,
      // Все именованные маршруты приложения объявлены в одном месте.
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case Routes.loading:
            return MaterialPageRoute<void>(
              builder: (_) => const LoadingPage(),
              settings: settings,
            );
          case Routes.login:
            return MaterialPageRoute<void>(
              builder: (_) => const LoginPage(),
              settings: settings,
            );
          case Routes.register:
            return MaterialPageRoute<UserProfileData>(
              builder: (_) => const RegisterPage(),
              settings: settings,
            );
          case Routes.home:
            final profile = settings.arguments;
            if (profile is UserProfileData) {
              return MaterialPageRoute<void>(
                builder: (_) => HomePage(profile: profile),
                settings: settings,
              );
            }
            break;
          case Routes.detail:
            final framework = settings.arguments;
            if (framework is FrameworkInfo) {
              return MaterialPageRoute<int>(
                builder: (_) => DetailPage(framework: framework),
                settings: settings,
              );
            }
            break;
        }
        return MaterialPageRoute<void>(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Маршрут не найден')),
          ),
        );
      },
    );
  }
}
