import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('Tutorials');
final FirebaseAuth auth = FirebaseAuth.instance;

class Database {
  static String? userUid;

  static Future<void> addItem({
    required String title,
    required String description,
    required String date,
    required String type,
  }) async {
    final User? user = auth.currentUser;
    final uid = user?.uid.toString();

    DocumentReference documentReferencer =
        _mainCollection.doc(uid).collection('Tutorials').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
      "date": date,
      "type": type,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Tutorial item added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> updateItem({
    required String title,
    required String description,
    required String date,
    required String type,
    required String docId,
  }) async {
    final User? user = auth.currentUser;
    final uid = user?.uid.toString();
    DocumentReference documentReferencer =
        _mainCollection.doc(uid).collection('Tutorials').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
      "date": date,
      "type": type,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Tutorial item updated in the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readItems() {

    final User? user = auth.currentUser;
    final uid = user?.uid.toString();
    CollectionReference notesItemCollection =
        _mainCollection.doc(uid).collection('Tutorials');

    return notesItemCollection.snapshots();
  }

  static Future<void> deleteItem({
    required String docId,
  }) async {
    final User? user = auth.currentUser;
    final uid = user?.uid.toString();

    DocumentReference documentReferencer =
        _mainCollection.doc(uid).collection('Tutorials').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Tutorial item deleted from the database'))
        .catchError((e) => print(e));
  }
}
