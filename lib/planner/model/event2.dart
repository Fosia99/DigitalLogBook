import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Event2 {
  final String title;
  final String? description;
  final DateTime date;
  final String id;
  final String tutorialType;

  Event2({
    required this.title,
    this.description,
    required this.date,
    required this.id,
    required this.tutorialType,
  });

  static Event2 fromFirestore2(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return Event2(
      date: data['date'].toDate(),
      title: data['title'],
      description: data['description'],
      id: snapshot.id,
      tutorialType: data['type'],
    );
  }
}
