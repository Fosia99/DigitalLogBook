import 'package:flutter/material.dart';
import '../theme/colors/light_colors.dart';
import '/data/accounts.dart';
import '/screens/teacher_classroom/add_class.dart';
import '/screens/teacher_classroom/classes_tab.dart';
import '/services/auth.dart';
import '/data/custom_user.dart';
import 'package:provider/provider.dart';

class TeacherHomePage extends StatefulWidget {
  @override
  _TeacherHomePageState createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final user = Provider.of<CustomUser?>(context);
    var account = getAccount(user!.uid);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Text(
          "My Classes",
          style: TextStyle(
              color: Colors.black, fontFamily: "Roboto", fontSize: 22),
        ),
        backgroundColor: Colors.white,
        actions: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text("Welcome, " + (account!.firstName as String),
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
          ),

        ],
      ),
      body: ClassesTab(account),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddClass(),
              )).then((_) => setState(() {}));
        },
        backgroundColor: LightColors.kGreen,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}
