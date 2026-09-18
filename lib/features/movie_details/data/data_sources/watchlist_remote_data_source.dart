import 'package:cloud_firestore/cloud_firestore.dart';

class WatchlistRemoteDataSource {
  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  Future<void> addToWatchlist({
    required String userId,
    required int movieId,
    required String title,
    required String imagePath,
  }) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('watchlist')
        .doc(movieId.toString())
        .set({
      'movieId': movieId,
      'title': title,
      'imagePath': imagePath,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> removeFromWatchlist({
    required String userId,
    required int movieId,
  }) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('watchlist')
        .doc(movieId.toString())
        .delete();
  }

  Future<List<Map<String, dynamic>>> getWatchlist({
    required String userId,
  }) async {
    final snapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('watchlist')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      return doc.data();
    }).toList();
  }
}