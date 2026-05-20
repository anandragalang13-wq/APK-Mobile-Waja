part of 'app_pages.dart';

/// Nama-nama route publik yang digunakan di seluruh aplikasi.
/// Gunakan kelas [Routes] untuk navigasi antar halaman.
///
/// Contoh penggunaan:
///   Navigator.pushNamed(context, Routes.HOME);
///   AppPages.to(context, Routes.NAKULA);
abstract class Routes {
  Routes._();

  static const SPLASH      = _Paths.SPLASH;
  static const LOGIN       = _Paths.LOGIN;
  static const AUTH        = _Paths.AUTH;
  static const HOME        = _Paths.HOME;
  static const PROFIL      = _Paths.PROFIL;
  static const CARI        = _Paths.CARI;
  static const NAKULA      = _Paths.NAKULA;
  static const RAHWANA     = _Paths.RAHWANA;
  static const CERITA_HOME = _Paths.CERITA_HOME;
  static const BARATAYUDA  = _Paths.BARATAYUDA;
}

/// Path string internal. Jangan gunakan langsung — pakai [Routes].
abstract class _Paths {
  _Paths._();

  static const SPLASH      = '/splash';
  static const LOGIN       = '/login';
  static const AUTH        = '/auth';
  static const HOME        = '/home';
  static const PROFIL      = '/profil';
  static const CARI        = '/cari';
  static const NAKULA      = '/nakula';
  static const RAHWANA     = '/rahwana';
  static const CERITA_HOME = '/cerita';
  static const BARATAYUDA  = '/cerita/baratayuda';
}