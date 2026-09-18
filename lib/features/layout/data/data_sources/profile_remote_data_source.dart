import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileRemoteDataSource {
  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  Future<void> updateProfile({
    required String userId,
    required String username,
    required String phone,
    required int selectedAvatar,
  }) async {
    await firestore.collection('users').doc(userId).set({
      'username': username,
      'phone': phone,
      'selectedAvatar': selectedAvatar,
    }, SetOptions(merge: true));
  }

  Future<Map<String, dynamic>?> getProfile({
    required String userId,
  }) async {
    final document = await firestore
        .collection('users')
        .doc(userId)
        .get();

    if (!document.exists) {
      return null;
    }

    return document.data();
  }
}