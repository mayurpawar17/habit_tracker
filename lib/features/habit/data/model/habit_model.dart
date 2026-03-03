import 'package:cloud_firestore/cloud_firestore.dart';

class Habit {
  final String id;
  final String title;
  final String color;
  final DateTime createdAt;
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

  factory Habit.fromMap(String id, Map<String, dynamic> data) {
    return Habit(
      id: id,
      title: data['title'] ?? '',
      color: data['color'] ?? '#4CAF50',
      // Converts Firestore Timestamp to Dart DateTime
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      frequency: data['frequency'] ?? 'daily',
      goal: (data['goal'] as num? ?? 0).toInt(),
      icon: data['icon'] ?? 'water_drop',
      isDone: data['isDone'] ?? false,
      reminderTime: data['reminderTime'] ?? '08:00',
      streak: (data['streak'] as num? ?? 0).toInt(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'color': color,
      'createdAt': Timestamp.fromDate(createdAt), // Converts back to Timestamp
      'frequency': frequency,
      'goal': goal,
      'icon': icon,
      'isDone': isDone,
      'reminderTime': reminderTime,
      'streak': streak,
    };
  }
}
