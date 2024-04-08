
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Event {
  final String uid;
  final String title;
  final String? description;
  final DateTime date;
  final String  time;
  final String id;
  final String sessionType;
  //final String tutorialType;

  Event({
    required this.uid,
    required this.title,
    this.description,
 required this.date,
    required this.time,
    required this.id,
    required this.sessionType,
    //required this.tutorialType,
  });



  static Event fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {

    final data = snapshot.data()!;
    return Event(
      uid: data['uid'],
      date: data['date'].toDate(),
      title: data['title'],
      description: data['description'],
      time: data['startTime'],
      id: snapshot.id,
      sessionType: data['logSession'],
    );
  }



  static Map<String, dynamic> toFirestore(Event event, SetOptions? options) {
    return {
      "uid": event.uid,
      "date": Timestamp.fromDate(event.date),
      "title": event.title,
      "description": event.description,
    };
  }

}
