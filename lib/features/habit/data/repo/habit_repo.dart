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

  // Future<void> createHabit(Habit habit) async {
  //   await _habitRef.add(habit.toMap());
  // }

  // ➕ ADD
  // Future<void> addHabit(String title) async {
  //   await _habitRef.add({
  //     'title': title,
  //     'isDone': false,
  //     'streak': 0,
  //     'createdAt': Timestamp.now(),
  //   });
  // }

  Future<void> createHabit({
    required String title,
    required int goal,
    required String frequency,
  }) async {
    // final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('habits')
        .add({
          "title": title,
          "goal": goal,
          "frequency": frequency,
          "streak": 0,
          "createdAt": FieldValue.serverTimestamp(),
        });
  }

  Future<List<Habit>> getHabits() async {
    // final uid = FirebaseAuth.instance.currentUser!.uid;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('habits')
        .get();

    return snapshot.docs
        .map((doc) => Habit.fromMap(doc.id, doc.data()))
        .toList();
  }

  Future<void> toggleHabit({
    required String habitId,
    required bool isDone,
  }) async {
    // final uid = FirebaseAuth.instance.currentUser!.uid;

    final dateId = DateFormat('yyyy-MM-dd').format(DateTime.now());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('habits')
        .doc(habitId)
        .collection('logs')
        .doc(dateId)
        .set({
          "isDone": isDone,
          "progress": isDone ? 1 : 0,
          "date": DateTime.now(),
          "completedAt": isDone ? FieldValue.serverTimestamp() : null,
        });
  }

  // 📖 READ (Stream)
  // Future<List<Habit>> getHabits() async {
  //   final snapshot = await _habitRef.orderBy('createdAt').get();
  //
  //   return snapshot.docs
  //       .map((doc) => Habit.fromMap(doc.id, doc.data() as Map<String, dynamic>))
  //       .toList();
  // }

  Future<List<Habit>> getHabitsForDate(DateTime date) async {
    // final uid = FirebaseAuth.instance.currentUser!.uid;

    final dateId = DateFormat('yyyy-MM-dd').format(date);

    final snapshot = await _db
        .collection('users')
        .doc(uid)
        .collection('habits')
        .get();
    print("Total habits found: ${snapshot.docs.length}");

    List<Habit> habits = [];

    for (var doc in snapshot.docs) {
      print("Checking habit: ${doc.id}");
      final log = await doc.reference.collection('logs').doc(dateId).get();
      final logs = await doc.reference.collection('logs').get();

      for (var l in logs.docs) {
        print("Existing log ID: ${l.id}");
      }

      print("Log exists: ${log.exists}");

      print("Log data: ${log.data()}");
      habits.add(
        Habit.fromMap(
          doc.id,
          doc.data(),
          isDone: (log.data()?['isDone'] as bool?) ?? false,
        ),
      );
    }

    return habits;
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

  Future<void> markHabitDone(String habitId, bool value) async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('habits')
        .doc(habitId)
        .collection('logs')
        .doc(today)
        .set({
          "date": DateTime.now(),
          "isDone": value,
          "progress": value ? 1 : 0,
          "completedAt": value ? FieldValue.serverTimestamp() : null,
        });
  }
}
