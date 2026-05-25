import 'package:flutter/material.dart';

// Auth
import '../auth/auth_page.dart';
import '../auth/auth_service.dart';
import '../auth/auth_state.dart';

// Pages
import '../pages/splash.dart';
import '../pages/login.dart';
import '../pages/register.dart';
import '../pages/halaman_utama.dart';
import '../pages/profil_page.dart';
import '../pages/cari_page.dart';
import '../pages/nakula.dart';
import '../pages/rahwana.dart';
// Note: semar.dart juga menggunakan class NakulaPage (duplikat), perlu direfactor
// import '../pages/semar.dart';

// Cerita
import '../cerita/cerita_home_page.dart';
import '../cerita/baratayuda.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = <String, WidgetBuilder>{
    _Paths.SPLASH: (context) => const SplashPage(),
    _Paths.LOGIN: (context) => const LoginPage(),
    _Paths.REGISTER: (context) => const RegisterPage(),
    _Paths.AUTH: (context) => const AuthPage(),
    _Paths.HOME: (context) => const WayangHomePage(),
    _Paths.PROFIL: (context) => const ProfilePage(),
    _Paths.CARI: (context) => const CariPage(),
    _Paths.NAKULA: (context) => const NakulaPage(),
    _Paths.RAHWANA: (context) => const RahwanaPage(),
    _Paths.CERITA_HOME: (context) => const CeritaHomePage(),
    _Paths.BARATAYUDA: (context) => const BaratayudaPage(),
  };

  /// Helper: navigasi ke halaman berdasarkan nama route
  static void to(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  /// Helper: navigasi dan hapus halaman sebelumnya
  static void offAll(BuildContext context, String routeName) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (route) => false,
    );
  }

  /// Helper: kembali ke halaman sebelumnya
  static void back(BuildContext context) {
    Navigator.pop(context);
  }
}