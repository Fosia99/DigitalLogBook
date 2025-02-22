
import '/data/custom_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountsDB {
  // object to get instance of Accounts table
  CollectionReference accountReference = FirebaseFirestore.instance.collection("Accounts");

  // uid used to reference the auth user
  CustomUser? user;

  AccountsDB({this.user});


  // function to update in database
  Future<void> updateAccounts(String fname, String lname, String type,String studentNo,String course,String year) async {
    return await accountReference.doc(user!.uid).set({
      'uid': user!.uid,
      'firstname': fname,
      'lastname': lname,
      'type': type,
      'studentNo': studentNo,
      'course': course,
      'year':year,
      'email': user!.email,
    });
  }


  // function to make list of accounts from DB
  Future<List?> createAccountDataList() async {

    var listOfAccount = [];

    await accountReference.get().then((ss)
    {
      if( ss != null)
      {
        listOfAccount = ss.docs.toList();
      }

      else
      {
        print("got no accounts");
        return [];
      }
    });

    return listOfAccount;
  }

}