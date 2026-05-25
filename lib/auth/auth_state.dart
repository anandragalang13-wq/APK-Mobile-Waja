import 'package:firebase_auth/firebase_auth.dart';

/// State autentikasi global yang sinkron dengan Firebase Auth.
/// Ini menggantikan class AuthState lama yang menggunakan variabel statis biasa.
///
/// Gunakan [AuthState.currentUser] untuk mendapatkan user yang sedang login.
/// Gunakan [AuthState.isLoggedIn] untuk cek status login.
class AuthState {
  AuthState._();

  static User? get currentUser => FirebaseAuth.instance.currentUser;

  static bool get isLoggedIn => currentUser != null;

  /// Nama tampilan pengguna (dari Firebase Auth atau Firestore).
  static String get username =>
      currentUser?.displayName ?? 'Pengguna WAJA';

  /// Email pengguna yang sedang login.
  static String get email => currentUser?.email ?? '';

  /// URL foto profil (bisa null jika belum diset).
  static String? get photoUrl => currentUser?.photoURL;

  /// UID unik pengguna di Firebase.
  static String get uid => currentUser?.uid ?? '';
}