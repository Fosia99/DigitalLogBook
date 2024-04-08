
import '/screens/NurseDashboardScreen.dart';
import '/screens/OccupationalDashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '/AppConfig.dart';
import '/theme/colors/light_colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'splash_screen.dart';
import '/screens/auth_screen.dart';
import '/data/accounts.dart';
import '/data/custom_user.dart';
import '/screens/Authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OverviewScreen extends StatefulWidget {
  static String TAG ="StudentMainPage";
  const OverviewScreen({Key ?key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OverviewScreenState();
  }



}

class _OverviewScreenState extends State<OverviewScreen> {


  @override
  Widget build(BuildContext context) {



      // getting user from the Stream Provider
      final user = Provider.of<CustomUser?>(context);

      // logic for if logged in
      if (user != null && accountExists(user.uid)) {
        var typeOfCurrentUser = getAccount(user.uid)!.course;
        return typeOfCurrentUser == 'Occupational Therapy'? OccupationalDashboardScreen() : DashboardScreenNurse();
      }


      // user is not logged in
      else return Authenticate();

    }
}