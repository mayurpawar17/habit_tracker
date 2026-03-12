import 'package:cloud_firestore/cloud_firestore.dart';

class Habit {
  final String id;
  final String title;
  final String color;
  final DateTime? createdAt;
  final String frequency;
  final int goal;
  final String icon;
  final bool isDone;
  final String reminderTime;
  final int streak;

  Habit({
    required this.id,
    required this.title,
    required this.color,
    required this.createdAt,
    required this.frequency,
    required this.goal,
    required this.icon,
    required this.isDone,
    required this.reminderTime,
    required this.streak,
  });

  factory Habit.fromMap(
    String id,
    Map<String, dynamic> data, {
    bool isDone = false,
  }) {
    return Habit(
      id: id,
      title: data['title'] ?? '',
      color: data['color'] ?? '#4CAF50',
      // Converts Firestore Timestamp to Dart DateTime
      // createdAt: (data['createdAt'] as Timestamp).toDate(),
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
      frequency: data['frequency'] ?? 'daily',
      goal: (data['goal'] as num? ?? 0).toInt(),
      icon: data['icon'] ?? 'water_drop',
      // isDone: data['isDone'] ?? false,
      isDone: isDone,
      reminderTime: data['reminderTime'] ?? '08:00',
      streak: (data['streak'] as num? ?? 0).toInt(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'color': color,
      'createdAt': createdAt, // Converts back to Timestamp
      'frequency': frequency,
      'goal': goal,
      'icon': icon,
      'isDone': isDone,
      'reminderTime': reminderTime,
      'streak': streak,
    };
  }
}

// import 'package:intl/intl.dart';
//
// class Habit {
//   final String id;
//   final DateTime? createdAt;
//   final int goal;
//   final bool isDone;
//   final int streak;
//   final String title;
//
//   Habit({
//     required this.id,
//     this.createdAt,
//     required this.goal,
//     required this.isDone,
//     required this.streak,
//     required this.title,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'createdAt': createdAt,
//       'goal': goal,
//       'streak': streak,
//       'title': title,
//     };
//   }
//
//   factory Habit.fromMap(
//       String id,
//       Map<String, dynamic> map, {
//         bool isDone = false,
//       }) {
//     return Habit(
//       id: id,
//       createdAt: map['createdAt'] != null
//           ? (map['createdAt'] as Timestamp).toDate()
//           : null,
//       goal: map['goal']?.toInt() ?? 0,
//       isDone: isDone,
//       streak: map['streak']?.toInt() ?? 0,
//       title: map['title'] ?? '',
//     );
//   }
// }
