import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

/// Service untuk semua operasi data wayang:
/// like, save, upload foto profil, ambil data profil.
class WayangService {
  WayangService._();
  static final WayangService instance = WayangService._();

  final _db   = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;

  String? get _uid => _auth.currentUser?.uid;

  // ─── LIKE WAYANG ────────────────────────────────────────────────────────────
  /// Toggle like pada tokoh wayang.
  /// Mengembalikan jumlah like terbaru setelah toggle.
  Future<int> toggleLikeWayang(String wayangId) async {
    if (_uid == null) throw Exception('Harus login dulu');

    final wayangRef  = _db.collection('wayang').doc(wayangId);
    final likeRef    = wayangRef.collection('likes').doc(_uid);

    return _db.runTransaction((tx) async {
      final likeSnap  = await tx.get(likeRef);
      final wayangSnap = await tx.get(wayangRef);

      int currentLikes = (wayangSnap.data()?['likes'] ?? 0) as int;

      if (likeSnap.exists) {
        // Sudah like → unlike
        tx.delete(likeRef);
        currentLikes = (currentLikes - 1).clamp(0, 999999);
        tx.set(wayangRef, {'likes': currentLikes}, SetOptions(merge: true));
      } else {
        // Belum like → like
        tx.set(likeRef, {'likedAt': FieldValue.serverTimestamp(), 'uid': _uid});
        currentLikes += 1;
        tx.set(wayangRef, {'likes': currentLikes, 'wayangId': wayangId},
            SetOptions(merge: true));

        // Simpan di profil user: liked_wayang
        tx.set(
          _db.collection('users').doc(_uid).collection('liked_wayang').doc(wayangId),
          {'wayangId': wayangId, 'likedAt': FieldValue.serverTimestamp()},
        );
      }
      return currentLikes;
    });
  }

  /// Cek apakah user sudah like wayang ini.
  Future<bool> isLikedWayang(String wayangId) async {
    if (_uid == null) return false;
    final doc = await _db
        .collection('wayang')
        .doc(wayangId)
        .collection('likes')
        .doc(_uid)
        .get();
    return doc.exists;
  }

  /// Ambil jumlah like wayang dari Firestore.
  Future<int> getLikesCount(String wayangId) async {
    final doc = await _db.collection('wayang').doc(wayangId).get();
    return (doc.data()?['likes'] ?? 0) as int;
  }

  /// Stream jumlah like (realtime).
  Stream<int> likesStream(String wayangId) {
    return _db.collection('wayang').doc(wayangId).snapshots().map(
          (snap) => (snap.data()?['likes'] ?? 0) as int,
        );
  }

  // ─── SAVE / BOOKMARK WAYANG ─────────────────────────────────────────────────
  /// Toggle save (bookmark) tokoh wayang ke profil user.
  Future<bool> toggleSaveWayang(String wayangId) async {
    if (_uid == null) throw Exception('Harus login dulu');

    final saveRef = _db
        .collection('users')
        .doc(_uid)
        .collection('saved_wayang')
        .doc(wayangId);

    final snap = await saveRef.get();
    if (snap.exists) {
      await saveRef.delete();
      return false; // sudah dihapus
    } else {
      await saveRef.set({
        'wayangId': wayangId,
        'savedAt': FieldValue.serverTimestamp(),
      });
      return true; // baru disimpan
    }
  }

  Future<bool> isSavedWayang(String wayangId) async {
    if (_uid == null) return false;
    final doc = await _db
        .collection('users')
        .doc(_uid)
        .collection('saved_wayang')
        .doc(wayangId)
        .get();
    return doc.exists;
  }

  // ─── LIKE CERITA ─────────────────────────────────────────────────────────────
  Future<int> toggleLikeCerita(String ceritaId) async {
    if (_uid == null) throw Exception('Harus login dulu');

    final ceritaRef = _db.collection('cerita').doc(ceritaId);
    final likeRef   = ceritaRef.collection('likes').doc(_uid);

    return _db.runTransaction((tx) async {
      final likeSnap   = await tx.get(likeRef);
      final ceritaSnap = await tx.get(ceritaRef);

      int currentLikes = (ceritaSnap.data()?['likes'] ?? 0) as int;

      if (likeSnap.exists) {
        tx.delete(likeRef);
        currentLikes = (currentLikes - 1).clamp(0, 999999);
        tx.set(ceritaRef, {'likes': currentLikes}, SetOptions(merge: true));
      } else {
        tx.set(likeRef, {'likedAt': FieldValue.serverTimestamp(), 'uid': _uid});
        currentLikes += 1;
        tx.set(ceritaRef, {'likes': currentLikes, 'ceritaId': ceritaId},
            SetOptions(merge: true));
        tx.set(
          _db.collection('users').doc(_uid).collection('liked_cerita').doc(ceritaId),
          {'ceritaId': ceritaId, 'likedAt': FieldValue.serverTimestamp()},
        );
      }
      return currentLikes;
    });
  }

  Future<bool> isLikedCerita(String ceritaId) async {
    if (_uid == null) return false;
    final doc = await _db
        .collection('cerita')
        .doc(ceritaId)
        .collection('likes')
        .doc(_uid)
        .get();
    return doc.exists;
  }

  // ─── SAVE CERITA ─────────────────────────────────────────────────────────────
  Future<bool> toggleSaveCerita(String ceritaId) async {
    if (_uid == null) throw Exception('Harus login dulu');

    final saveRef = _db
        .collection('users')
        .doc(_uid)
        .collection('saved_cerita')
        .doc(ceritaId);

    final snap = await saveRef.get();
    if (snap.exists) {
      await saveRef.delete();
      return false;
    } else {
      await saveRef.set({
        'ceritaId': ceritaId,
        'savedAt': FieldValue.serverTimestamp(),
      });
      return true;
    }
  }

  // ─── UPLOAD FOTO PROFIL ──────────────────────────────────────────────────────
  /// Pilih gambar dari galeri/kamera dan upload ke Firebase Storage.
  /// Mengembalikan URL foto yang baru.
  Future<String?> uploadFotoProfil({bool fromCamera = false}) async {
    if (_uid == null) return null;

    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );

    if (picked == null) return null;

    final file = File(picked.path);
    final ref  = _storage.ref('profile_photos/$_uid.jpg');

    await ref.putFile(
      file,
      SettableMetadata(contentType: 'image/jpeg'),
    );

    final url = await ref.getDownloadURL();

    // Update Firestore dan Firebase Auth
    await Future.wait([
      _db.collection('users').doc(_uid).update({
        'photoUrl': url,
        'updatedAt': FieldValue.serverTimestamp(),
      }),
      _auth.currentUser!.updatePhotoURL(url),
    ]);

    return url;
  }

  // ─── GET LIKED & SAVED WAYANG USER ──────────────────────────────────────────
  /// Ambil list wayangId yang disukai user (untuk halaman profil).
  Future<List<String>> getLikedWayangIds() async {
    if (_uid == null) return [];
    final snap = await _db
        .collection('users')
        .doc(_uid)
        .collection('liked_wayang')
        .orderBy('likedAt', descending: true)
        .get();
    return snap.docs.map((d) => d.id).toList();
  }

  Future<List<String>> getSavedWayangIds() async {
    if (_uid == null) return [];
    final snap = await _db
        .collection('users')
        .doc(_uid)
        .collection('saved_wayang')
        .orderBy('savedAt', descending: true)
        .get();
    return snap.docs.map((d) => d.id).toList();
  }

  Future<List<String>> getLikedCeritaIds() async {
    if (_uid == null) return [];
    final snap = await _db
        .collection('users')
        .doc(_uid)
        .collection('liked_cerita')
        .orderBy('likedAt', descending: true)
        .get();
    return snap.docs.map((d) => d.id).toList();
  }

  Future<List<String>> getSavedCeritaIds() async {
    if (_uid == null) return [];
    final snap = await _db
        .collection('users')
        .doc(_uid)
        .collection('saved_cerita')
        .orderBy('savedAt', descending: true)
        .get();
    return snap.docs.map((d) => d.id).toList();
  }
}