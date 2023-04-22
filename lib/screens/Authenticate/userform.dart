
import '/data/custom_user.dart';
import '/screens/loading.dart';
import '/screens/wrapper.dart';
import '/services/accounts_db.dart';
import '/services/updatealldata.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Userform extends StatefulWidget {
  const Userform({Key? key}) : super(key: key);

  @override
  _UserformState createState() => _UserformState();
}

class _UserformState extends State<Userform> {
  String firstname = "";
  String lastname = "";
  String type = "student";
  String studentNo = "20121212";
  String course = "Occupational Therapy";
  String year = "1";
  String error = "";

  // for form validation
  final _formKey = GlobalKey<FormState>();

  // for loading screen
  bool loading = false;



  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    final AccountsDB pointer = AccountsDB(user: user!);

    return loading ? Loading() : Scaffold(
        appBar: AppBar(
          title: Text(
            "User Details",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          // form widget
          child: Form(

            // form key for validation( check above)
              key: _formKey,
              child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                    child: Column(
                      children: [
                        SizedBox(height: 20.0),

                        // textbox for name
                        TextFormField(
                          decoration: InputDecoration(labelText: "First Name", border: OutlineInputBorder()),
                          validator: (val) =>
                          val!.isEmpty ? 'Enter an First Name' : null,
                          onChanged: (val) {
                            setState(() {
                              firstname = val;
                            });
                          },
                        ),

                        SizedBox(height: 20.0),

                        // textbox for name
                        TextFormField(
                          decoration: InputDecoration(labelText: "Last Name", border: OutlineInputBorder()),
                          onChanged: (val) {
                            setState(() {
                              lastname = val;
                            });
                          },
                        ),

                        SizedBox(height: 20.0),


                        DropdownButtonFormField(
                          decoration: InputDecoration(labelText: "Role", border: OutlineInputBorder()),
                          value: "Student",
                          onChanged: (newValue) {
                            setState(() {
                              type = (newValue as String).toLowerCase();
                            });
                          },
                          items: ['Student', 'Lecturer','Supervisor'].map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),

                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: InputDecoration(labelText: "Student Number", border: OutlineInputBorder()),
                          onChanged: (val) {
                            setState(() {
                              studentNo = val;
                            });
                          },
                        ),
                        SizedBox(height: 20.0),
                        DropdownButtonFormField(
                          decoration: InputDecoration(labelText: "Course", border: OutlineInputBorder()),
                          value: "Occupational Therapy",
                          onChanged: (newValue) {
                            setState(() {
                              course = (newValue as String).toLowerCase();
                            });
                          },
                          items: ['Occupational Therapy', 'Pharmacy','Nurse'].map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 20.0),
                        DropdownButtonFormField(
                          decoration: InputDecoration(labelText: "Year", border: OutlineInputBorder()),
                          value: "1",
                          onChanged: (newValue) {
                            setState(() {
                             year = (newValue as String).toLowerCase();
                            });
                          },
                          items: ['1', '2','3','4'].map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 20.0),
                        // register button
                        ElevatedButton(
                          child: Text("Register"),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => loading = true);

                              // adding to db
                              await pointer.updateAccounts(firstname, lastname, type,studentNo,course,year);

                              await updateAllData();

                              setState(() => loading = false);

                              // popping to Wrapper to go to class
                              Navigator.pushReplacement(context, MaterialPageRoute( builder: (context) => Wrapper()));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                          ),
                        ),

                        SizedBox(height: 12.0),

                        // Prints error if any while registering
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        )
                      ],
                    ),
                  ))),
        ));
  }
}
