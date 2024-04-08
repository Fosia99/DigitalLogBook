import 'package:digital_logbook/LectureScreens/myStudents.dart';
import 'package:digital_logbook/screens/logout.dart';
import 'StudentGrades.dart';
import 'assessments.dart';
import 'profile.dart';
import '/screens/LogSession.dart';
import 'package:flutter/material.dart';
import '/AppConfig.dart';
import '/screens/ClinicListScreen.dart';
import '/screens/Planner.dart';
import '/screens/PlannerHome.dart';
import '/screens/ProfilePage.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/theme/colors/light_colors.dart';

class LecturerDashboardScreen extends StatefulWidget{
  static String TAG ="OTDashboard";
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LecturerDashboardScreenState();
  }
  
}
class LecturerDashboardScreenState extends State<LecturerDashboardScreen>{


  var lstOptions=
  [
    {
      "icon":"assets/images/otlog2.png",
      "title":"STUDENT LOG SESSION"

    },

    {
      "icon":"assets/images/otplanner.png",
      "title":"PLANNER"

    },
    {
      "icon":"assets/images/otprofile.png",
      "title":"PROFILE"

    },

    {
      "icon":"assets/images/ottut.png",
      "title":"STUDENT TUTORIALS"

    },
    {
      "icon":"assets/images/otreport.png",
      "title":"REPORTS"

    },
    {
      "icon":"assets/images/otmaterial.png",
      "title":"STUDY MATERIALS"

    },
    {
      "icon":"assets/images/otmaterial.png",
      "title":"Log out"

    }

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.kDarkYellow,
        title: const Text("LECTURE  ---- Home", style: TextStyle(color: Colors.black,),),
        actions: [
          //IconButton(icon: Icon(Icons.search, color: Colors.grey,), onPressed: () {}),

        ],

      ),
      body: ListView(
          children: [
            CarouselSlider(
              items: [
                Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0.0),
                    image: DecorationImage(
                      image: AssetImage("assets/images/otplanner.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image:AssetImage("assets/images/otlog2.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: AssetImage("assets/images/othome.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: AssetImage("assets/images/otprofile.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: AssetImage("assets/images/ottut.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: AssetImage("assets/images/otreport.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
              options: CarouselOptions(
                height: 450.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 600),
                viewportFraction: 0.8,
              ),
            ),
          ]),

      drawer: Drawer(
        backgroundColor: Colors.white,
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(


              decoration: BoxDecoration(
                color: LightColors.kGreen,
                image:DecorationImage(image: AssetImage("assets/images/otplanner.png"),
                    fit: BoxFit.cover,
                )

              ),
              child: Text(''),
            ),

            ListTile(
              leading: Icon(Icons.add_alert_outlined),
              title: const Text('Student Log Sessions',style: TextStyle( fontSize: 16.0,color: Colors.black87,fontWeight: FontWeight.bold)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyStudents(),
                  ),
                );
              },
            ),
            Divider(
              color: LightColors.kLightGreen,
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: const Text('Grades',style: TextStyle( fontSize: 16.0,color: Colors.black87,fontWeight: FontWeight.bold)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentsGrades(),
                  ),
                );
              },
            ),

            Divider(
              color: LightColors.kLightGreen,
            ),
            ListTile(
              leading: Icon(Icons.calendar_today_outlined),
              title: const Text('Planner',style: TextStyle( fontSize: 16.0,color: Colors.black87,fontWeight: FontWeight.bold)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushReplacement(
                  context,
                MaterialPageRoute(
                   builder: (context) =>  Planner(),
                  ),
                );
              },
            ),
            Divider(
              color: LightColors.kLightGreen,
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: const Text('My Profile',style: TextStyle( fontSize: 16.0,color: Colors.black87,fontWeight: FontWeight.bold)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile(),
                  ),
                );
              },
            ),


            const Divider(
              color: LightColors.kLightGreen,
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log out',style: TextStyle( fontSize: 16.0,color: Colors.black87,fontWeight: FontWeight.bold)),
              onTap: () {
                // Update the state of the app
                // ...
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut();


              },
            ),
            const Divider(
              color: LightColors.kLightGreen,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getDashboardBody()
  {
    return StaggeredGridView.countBuilder(crossAxisCount: 2,

        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        primary: true,
        itemCount: lstOptions.length,
        itemBuilder: (_,index){
           return InkWell(
             onTap: (){
               if(index==0)
                 {

                 }
               else if(index==1)
                 {

                 }
               else if(index==2)
               {

               }
             },

           );
        },
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(1));

  }


}