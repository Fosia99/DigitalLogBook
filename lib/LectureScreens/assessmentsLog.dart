import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../screens/LogSession.dart';
import '/theme/colors/light_colors.dart';
import 'MyStudents.dart';

class assessmentsLogs extends StatefulWidget {
  static String TAG = "LogSession";

  late final docId;
  late final docName;
  late final rotNum;

  assessmentsLogs(this.docId,this.docName, this.rotNum);

  @override
  _assessmentsLogsState createState() => _assessmentsLogsState(docId,docName, rotNum);
}

class _assessmentsLogsState extends State<assessmentsLogs> {
  final docId;
  final docName;
  late final rotNum;

  _assessmentsLogsState(this.docId,this.docName, this.rotNum);

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    String title = "";
    return SingleChildScrollView(
        child: Container(
            child: Column(children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  onChanged: (val) {
                    setState(() {
                      title = val;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Search',
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Row(children: [
                Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 25),
                      height: 150,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: (title != "")
                            ? FirebaseFirestore.instance
                            .collection('direct')
                            .where('uid', isEqualTo: docId)
                            .where('rotation', isEqualTo: rotNum)
                            .where('status', isEqualTo: 'marked')
                            .where("searchKeywords", arrayContains: title)
                            .snapshots()
                            : FirebaseFirestore.instance
                            .collection('Indirect')
                            .where('uid', isEqualTo: docId)
                            .where('rotation', isEqualTo: rotNum)
                            .where('status', isEqualTo: 'marked')
                        //.orderBy('date')
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          double sum = 0.0;
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return ListView.builder(
                                padding: EdgeInsets.only(bottom: 10),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  final DocumentSnapshot doc = snapshot.data!
                                      .docs[index];
                                  sum += double.parse(doc['mark']);

                                  _navigateToTop(sum);
                                  return Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Card(
                                          color: Colors.white70,
                                          child: ListTile(
                                            leading: Icon(Icons.star),
                                            title: Text( "Title:  " +
                                              doc['title'],
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text( "Marks:  " +
                                              doc['mark'],
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ]);
                                });
                          }
                        },
                      ),
                    ))
              ])
            ])));
  }
     _navigateToTop(sum) {
       return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Card(
              color: Colors.white70,
              child: ListTile(
                title: Text(
                  "Total marks" + sum.toString(),
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ]
      );
    }
  }
