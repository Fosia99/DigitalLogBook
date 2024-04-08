// ignore_for_file: prefer_const_constructors

import 'package:digital_logbook/LectureScreens/LecturerDashboardScreen.dart';
import 'package:digital_logbook/screens/OccupationalDashboardScreen.dart';

import '/data/accounts.dart';
import '/data/custom_user.dart';
import '/screens/Authenticate/authenticate.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'SupervisorDashboardScreen.dart';
import 'overview_screen.dart';

class Wrapper extends StatefulWidget {
  static String TAG ="wrapper";
  const Wrapper({Key ? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  @override
  Widget build(BuildContext context) {


    // getting user from the Stream Provider
    final user = Provider.of<CustomUser?>(context);

    // logic for if logged in
    if (user != null && accountExists(user.uid)) {
      var typeOfCurrentUser = getAccount(user.uid)!.type;

      if (typeOfCurrentUser == 'student'){
        return  OccupationalDashboardScreen();
      }
      else if(typeOfCurrentUser == 'lecture'){
        return LecturerDashboardScreen();
      }

      else {
        return SupervisorDashboardScreen();
      }

    }


    // user isnt logged in
    else return Authenticate();

  }
}
