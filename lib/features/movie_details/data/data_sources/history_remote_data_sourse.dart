import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryRemoteDataSource {
  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  Future<void> addToHistory({
    required String userId,
    required int movieId,
    required String title,
    required String imagePath,
  }) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('history')
        .doc(movieId.toString())
        .set({
      'movieId': movieId,
      'title': title,
      'imagePath': imagePath,
      'visitedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<List<Map<String, dynamic>>> getHistory({
    required String userId,
  }) async {
    final snapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('history')
        .orderBy('visitedAt', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      return doc.data();
    }).toList();
  }
}