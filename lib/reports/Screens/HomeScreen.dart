import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import '/reports/utilites/FirebaseRepos.dart';


class ReportsPageApp extends StatefulWidget {
  const ReportsPageApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ReportsPageAppState();
  }
}
class _ReportsPageAppState extends State<ReportsPageApp> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseRepos _repos = FirebaseRepos();
  List<String> myItems = [];
  String userName = 'Hello';
  final FirebaseAuth auth = FirebaseAuth.instance;


  alertDialog(String name, BuildContext context) {
    return AlertDialog(
      title: const Text("Upload File"),
      content: Text(name),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text("Upload"),
          onPressed: ()async {

            final User user = await auth.currentUser!;
            final uid = user.uid.toString();
            // Navigator.of(context).pop();
            _repos.addUserData(uid, name).then((value) {
              Navigator.of(context).pop();
            });
          },
        ),
      ],
    );
  }

  singleTile(List<QueryDocumentSnapshot> list, int index) {
    return ListTile(
        leading: AspectRatio(
          aspectRatio: 1,
          child: Image.asset('assets/dragonBall.png')),
        title: Text(
          list[index]['itemName'],
          style: GoogleFonts.robotoMono(
            textStyle: TextStyle(color: Colors.white),
          ),
        ));
  }

  bodyApp(BuildContext context) {
   final User user =  auth.currentUser!;
    final uid = user.uid.toString();
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('items')
          .where('email', isEqualTo: uid)
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return ListView.builder(

          itemBuilder: (context, index) {
            if (snapshot.hasData && snapshot.data != null) {
              return singleTile(snapshot.data!.docs, index);
            } else {
              return Container(
                height: 0,
              );
            }
          },
          itemCount: snapshot.data == null ? 0 : snapshot.data?.docs.length,
        );
      },
    );
  }
  Future<File?> pickFiles() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any, allowMultiple: false);

    if (result != null && result.files.isNotEmpty) {
      final fileBytes = result.files.first.bytes;
      final fileName = result.files.first.name;

      // upload file
      await FirebaseStorage.instance.ref('uploads/$fileName').putData(fileBytes!);
  }
  @override
  initState() {
    FirebaseFirestore.instance
        .collection('Accounts')
        .doc('email')
        .get()
        .then((value) {
      setState(() {
        userName = 'Hello ${value.data()!['firstname']} !!'.toLowerCase();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(userName, style: GoogleFonts.hind()),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              }),
        ],
      ),

      body: bodyApp(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pickFiles().then((File? file) {
            if (file != null) {
              print(file.path);
              List<String> li = file.uri.path.split('/');
              String name=li[li.length-1];
              print(name);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alertDialog(name, context);
                },
              );
            }
            else {
              print("I dont have any file");
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

