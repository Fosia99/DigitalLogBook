import '/reports/utilites/FirebaseMEthods.dart';

class FirebaseRepos
{
  FirebaseMethods methods=new FirebaseMethods();
  Future<void> addUser(String userName, String uid) =>methods.addUser(userName, uid);

  Future<void> addUserData(String uid, String itemName)=>methods.addUserData(uid, itemName);

}