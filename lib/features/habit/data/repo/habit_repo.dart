import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HabitService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String? get uid => _auth.currentUser?.uid;

  CollectionReference get _habitRef =>
      _db.collection('users').doc(uid).collection('habits');

  // ➕ ADD
  Future<void> addHabit(String title) async {
    await _habitRef.add({
      'title': title,
      'isDone': false,
      'streak': 0,
      'createdAt': Timestamp.now(),
    });
  }

  // 📖 READ (Stream)
  Stream<QuerySnapshot> getHabits() {
    return _habitRef.orderBy('createdAt').snapshots();
  }

  // ✏️ UPDATE
  Future<void> updateHabit(String id, Map<String, dynamic> data) async {
    await _habitRef.doc(id).update(data);
  }

  // ❌ DELETE
  Future<void> deleteHabit(String id) async {
    await _habitRef.doc(id).delete();
  }
}
