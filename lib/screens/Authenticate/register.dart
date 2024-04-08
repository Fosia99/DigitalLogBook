// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables
// @dart=2.15
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:digital_logbook/theme/colors/light_colors.dart';

import '/screens/Authenticate/userform.dart';
import '/screens/loading.dart';
import '/services/auth.dart';
import 'package:flutter/material.dart';
import '/services/updatealldata.dart';

class Register extends StatefulWidget {
  final Function toggle_reg_log;

  Register({required this.toggle_reg_log});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Authservice object for accessing all auth related functions
  // More details inside "services/auth.dart" file
  final AuthService _auth = AuthService();

  // email and password strings
  String email = '';
  String password = '';
  String error = '';

  // for form validation
  final _formKey = GlobalKey<FormState>();

  // for loading screen
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            // appbar part
            appBar: AppBar(
              title: Text(
                "Register",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: LightColors.kYellow,
              actions: [
                // login button on the top right corner of appbar
                TextButton.icon(
                  onPressed: () {
                    widget.toggle_reg_log();
                  },
                  icon: Icon(Icons.person),
                  label: Text('Login'),
                  style: TextButton.styleFrom(primary: Colors.black),
                )
              ],
            ),

            // body part
            body: Column(children: <Widget>[
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(15.0, 50.0, 0.0, 0.0),
                      child: const Text('Hi',
                          style: TextStyle(
                              color: LightColors.kYellow,
                              fontSize: 80.0,
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(15.0, 125.0, 0.0, 0.0),
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontFamily: "Raleway",
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          color: LightColors.kDarkYellow,
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            WavyAnimatedText("There"),
                            WavyAnimatedText('Again'),
                          ],
                          isRepeatingAnimation: false,
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(235.0, 125.0, 0.0, 0.0),
                      child: const Text('.',
                          style: TextStyle(
                              fontSize: 80.0,
                              fontWeight: FontWeight.bold,
                            color: LightColors.kDarkYellow,)),
                    )
                  ],
                ),
                Form(
                  // form widget
                  child: Form(

                      // form key for validation( check above)
                      key: _formKey,
                      child: SingleChildScrollView(
                          child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 50.0),
                        child: Column(
                          children: [
                            SizedBox(height: 20.0),

                            // textbox for email
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: "Email",
                                  border: OutlineInputBorder()),
                              validator: (val) =>
                                  val!.isEmpty ? 'Enter an email' : null,
                              onChanged: (val) {
                                setState(() {
                                  email = val;
                                });
                              },
                            ),

                            SizedBox(height: 20.0),

                            // textbox for password
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: "Password",
                                  border: OutlineInputBorder()),
                              obscureText: true,
                              validator: (val) => val!.length < 6
                                  ? 'Enter a password 6+ chars long'
                                  : null,
                              onChanged: (val) {
                                setState(() {
                                  password = val;
                                });
                              },
                            ),

                            SizedBox(height: 20.0),

                            // register button
                            ElevatedButton(
                              child: Text("Register",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Roboto",
                                      fontSize: 22)),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() => loading = true);

                                  // Registering new student
                                  var result = await _auth.registerStudent(
                                      email, password);
                                  if (result == null) {
                                    setState(() {
                                      loading = false;
                                      error =
                                          'Some error in Registering! Please check again';
                                    });
                                  } else {
                                    await updateAllData();

                                    setState(() => loading = false);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Userform()));
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary:LightColors.kYellow,
                                minimumSize: Size(150, 50),
                              ),
                            ),

                            SizedBox(height: 12.0),

                            // Prints error if any while registering
                            Text(
                              error,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 14.0),
                            )
                          ],
                        ),
                      ))),
                )
              ])
            ]));
  }
}
