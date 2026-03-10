import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habit_tracker/features/habit/data/model/habit_model.dart';
import 'package:intl/intl.dart';

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
  Future<List<Habit>> getHabits() async {
    final snapshot = await _habitRef.orderBy('createdAt').get();

    return snapshot.docs
        .map((doc) => Habit.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList();
  }

  // ✏️ UPDATE
  Future<void> updateHabit(String id, Map<String, dynamic> data) async {
    await _habitRef.doc(id).update(data);
  }

  // ❌ DELETE
  Future<void> deleteHabit(String id) async {
    await _habitRef.doc(id).delete();
  }

  // Future<void> updateHabitStatus(String habitId, bool isDone) async {
  //   await _habitRef.doc(habitId).update({"isDone": isDone});
  // }

  Future<void> markHabitDone(String habitId, bool isDone) async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('habits')
        .doc(habitId)
        .collection('logs')
        .doc(today)
        .set({"date": today, "isDone": isDone});
  }
}
