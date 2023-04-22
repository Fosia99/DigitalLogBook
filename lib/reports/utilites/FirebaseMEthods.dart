import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseMethods {

  CollectionReference users = FirebaseFirestore.instance.collection('Accounts');
  CollectionReference items = FirebaseFirestore.instance.collection('items');

  //1


//2


  //3
  Future<void> addUser(String userName, String uid) async {
    await users.doc('uid').set({'firstname': userName, 'uid': uid});
  }
  
  //4
  Future<void> addUserData(String uid, String itemName)
  async{
    await items.add({
      'uid' :uid,
      'itemName' :itemName,
      'time' : DateTime.now(),
    });
  }

  //5
  Future<bool> checkEmail(String _uid)
  async{
    QuerySnapshot response= await FirebaseFirestore.instance.collection('Accounts').where('uid', isEqualTo: _uid).get();
    int len=response.docs.length;
    return len>0;
  }
}
