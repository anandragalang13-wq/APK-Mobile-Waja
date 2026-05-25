import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Service untuk semua operasi autentikasi Firebase.
/// Gunakan [AuthService.instance] untuk akses singleton.
class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // ─── Stream status login ────────────────────────────────────────────────────
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// User yang sedang login (null jika belum login).
  User? get currentUser => _auth.currentUser;

  // ─── REGISTER dengan Email & Password ──────────────────────────────────────
  /// Mendaftarkan akun baru dan menyimpan profil ke Firestore.
  /// Melempar [AuthException] jika gagal.
  Future<User?> registerWithEmail({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = credential.user;
      if (user != null) {
        // Update display name di Firebase Auth
        await user.updateDisplayName(username.trim());

        // Simpan data profil ke Firestore collection "users"
        await _saveUserToFirestore(
          uid: user.uid,
          username: username.trim(),
          email: email.trim(),
          photoUrl: user.photoURL,
          provider: 'email',
        );
      }
      return user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // ─── LOGIN dengan Email & Password ─────────────────────────────────────────
  Future<User?> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // ─── GOOGLE SIGN-IN ─────────────────────────────────────────────────────────
  /// Login/Register menggunakan akun Google.
  /// Otomatis membuat dokumen Firestore jika pengguna baru.
  Future<User?> signInWithGoogle() async {
    try {
      // Trigger alur login Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // Dibatalkan pengguna

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        // Cek apakah sudah ada di Firestore (pengguna lama)
        final docSnap =
            await _firestore.collection('users').doc(user.uid).get();

        if (!docSnap.exists) {
          // Pengguna baru via Google — buat dokumen Firestore
          await _saveUserToFirestore(
            uid: user.uid,
            username: user.displayName ?? 'Pengguna WAJA',
            email: user.email ?? '',
            photoUrl: user.photoURL,
            provider: 'google',
          );
        }
      }
      return user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw AuthException('Gagal masuk dengan Google: ${e.toString()}');
    }
  }

  // ─── LOGOUT ─────────────────────────────────────────────────────────────────
  Future<void> signOut() async {
    await Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  // ─── RESET PASSWORD ─────────────────────────────────────────────────────────
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // ─── GET PROFIL DARI FIRESTORE ──────────────────────────────────────────────
  /// Ambil data profil pengguna dari Firestore.
  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.data();
  }

  /// Stream profil pengguna (realtime updates).
  Stream<DocumentSnapshot<Map<String, dynamic>>> userProfileStream(
      String uid) {
    return _firestore.collection('users').doc(uid).snapshots();
  }

  // ─── UPDATE PROFIL ───────────────────────────────────────────────────────────
  Future<void> updateProfile({
    required String uid,
    String? username,
    String? photoUrl,
  }) async {
    final Map<String, dynamic> updates = {
      'updatedAt': FieldValue.serverTimestamp(),
    };
    if (username != null) updates['username'] = username;
    if (photoUrl != null) updates['photoUrl'] = photoUrl;

    await _firestore.collection('users').doc(uid).update(updates);

    if (username != null) {
      await _auth.currentUser?.updateDisplayName(username);
    }
  }

  // ─── HELPERS PRIVATE ────────────────────────────────────────────────────────
  Future<void> _saveUserToFirestore({
    required String uid,
    required String username,
    required String email,
    String? photoUrl,
    required String provider,
  }) async {
    await _firestore.collection('users').doc(uid).set({
      'uid': uid,
      'username': username,
      'email': email,
      'photoUrl': photoUrl ?? '',
      'provider': provider,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Konversi FirebaseAuthException ke pesan Indonesia yang ramah.
  AuthException _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return AuthException('Password minimal 6 karakter.');
      case 'email-already-in-use':
        return AuthException('Email sudah terdaftar. Silakan login.');
      case 'invalid-email':
        return AuthException('Format email tidak valid.');
      case 'user-not-found':
        return AuthException('Akun tidak ditemukan.');
      case 'wrong-password':
        return AuthException('Password salah.');
      case 'invalid-credential':
        return AuthException('Email atau password salah.');
      case 'user-disabled':
        return AuthException('Akun ini telah dinonaktifkan.');
      case 'too-many-requests':
        return AuthException(
            'Terlalu banyak percobaan. Coba lagi nanti.');
      case 'network-request-failed':
        return AuthException('Koneksi internet bermasalah.');
      default:
        return AuthException('Terjadi kesalahan: ${e.message}');
    }
  }
}

/// Exception khusus untuk error autentikasi dengan pesan Indonesia.
class AuthException implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  String toString() => message;
}