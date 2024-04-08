// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, non_constant_identifier_names

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:digital_logbook/theme/colors/light_colors.dart';

import '../wrapper.dart';
import '/screens/loading.dart';
import '/services/auth.dart';
import 'package:flutter/material.dart';
import '/services/updatealldata.dart';

class Login extends StatefulWidget {
  final Function toggle_reg_log;

  Login({required this.toggle_reg_log});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Authservice object for logging in
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

  // build func
  @override
  Widget build(BuildContext context) {
    // checking if not loading then show the page
    return loading
        ? Loading()
        : Scaffold(
            // appbar part
            appBar: AppBar(

              title: Text("Login", style: TextStyle(color: Colors.black)),
              backgroundColor:  LightColors.kDarkYellow,
              actions: [
                TextButton.icon(
                  onPressed: () {
                    widget.toggle_reg_log();
                  },
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                  style: TextButton.styleFrom(primary: Colors.white),
                )
              ],
            ),

            // body part

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
                              color: LightColors.kDarkYellow,
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
                          color: LightColors.kYellow,
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
                              color: LightColors.kYellow,)),
                    )
                  ],
                ),
                Form(
                      key: _formKey,
                    child: Container(
                        padding: const EdgeInsets.only(
                            top: 54.0, left: 20.0, right: 30.0),
                      child: Column(

                        children: [
                          SizedBox(height: 20.0),

                          // textbox for email
                          TextFormField(
                            decoration: InputDecoration(
                              hoverColor: LightColors.kYellow,
                              fillColor:Colors.black,
                                labelText: "Email",
                                border: OutlineInputBorder(
                                )),
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

                          SizedBox(height: 40.0),

                          // Login  button
                          ElevatedButton(
                            child: Text("Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Roboto",
                                    fontSize: 22)),
                            onPressed: () async {


                              if (_formKey.currentState!.validate()) {
                                setState(() => loading = true);

                                await updateAllData();

                                // Logging into the account
                                var result =
                                    await _auth.loginStudent(email, password);

                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    error =
                                        'Some error in logging in! Please check again';
                                  });
                                } else {

                                  print("\t\t\tUser Logged in Successfully");
                                 // Navigator.pushNamed(context,Wrapper.TAG);
                                  setState(() => loading = false);
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary:LightColors.kDarkYellow,
                              minimumSize: Size(150, 50),
                            ),
                          ),

                          SizedBox(height: 12.0),
                          // Prints error if any while logging in
                          Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 14.0),
                          )
                        ],
                      )),
                ),
              ])
            ]));
  }
}


