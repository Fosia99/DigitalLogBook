// @dart=2.15
import 'package:digital_logbook/screens/Planner.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors

import '/data/custom_user.dart';
import '/screens/wrapper.dart';
import '/services/auth.dart';
import '/services/updatealldata.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'screens/ClinicListScreen.dart';
import '/screens/LogSession.dart';
import '/screens/NurseDashboardScreen.dart';
import '/screens/NurseEmergencyCareHome.dart';
import '/screens/NurseReportingHome.dart';
import '/screens/OccupationalDashboardScreen.dart';
import '/screens/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/overview_screen.dart';
import 'screens/splash_screen.dart';
import '/screens/auth_screen.dart';
import '/screens/overview_screen.dart';
import 'package:device_preview/device_preview.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(// Replace with actual values
    options: const FirebaseOptions(
      apiKey: "AIzaSyBBRu2-FZdnysa_suQAQgQGKDAUnDqDqVo",
      appId: "1:837424323987:android:31059b1fef94b2b4005c66",
      storageBucket: "gs://your-app_name.appspot.com/",
      messagingSenderId: "837424323987",
      projectId: "digitallogbook-762f5",

    ),);
  // ignore: deprecated_member_use
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
  await updateAllData();

  runApp(DevicePreview(
    enabled: true,
    builder: (BuildContext context) => const Home(),
    ),
  );
}
// it just returns basic settings for MaterialApp
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return StreamProvider<CustomUser?>.value(
      // value is the stream method declared in "services.auth.dart"
        value: AuthService().streamUser,
        initialData: null,
        // MaterialApp
        child: MaterialApp(
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
            //debugShowCheckedModeBanner: false,
            home: Wrapper(),
          routes: {
            OccupationalDashboardScreen.TAG:(context)=>OccupationalDashboardScreen(),
            OverviewScreen.TAG:(context)=> OverviewScreen(),
            LogSession.TAG:(context)=>LogSession(),
            DashboardScreenNurse.TAG:(context)=>DashboardScreenNurse(),
            ProfilePage.TAG:(context) =>ProfilePage(),
            Planner.TAG:(context) => Planner(),

            ClinicListScreen.TAG:(context)=>ClinicListScreen(),

            EmergencyCare.TAG:(context)=> EmergencyCare(),
            //OperatingDefibrillator.TAG:(context)=>OperatingDefibrillator(),
            //PerformingTriage.TAG:(context)=> PerformingTriage(),
            NurseReportingHome.TAG:(context) => NurseReportingHome(),


          },
        ),
        );
  }
}

// void main() => runApp(OnlineClassroomApp());
//
// class OnlineClassroomApp extends StatefulWidget {
//   @override
//   _OnlineClassroomAppState createState() => _OnlineClassroomAppState();
// }
//
// class _OnlineClassroomAppState extends State<OnlineClassroomApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Classroom App",
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }