
import 'package:flutter/material.dart';
import '/AppConfig.dart';
import '/screens/ClinicListScreen.dart';
import '/screens/LogSession.dart';
import '/screens/NurseEmergencyCareHome.dart';
import '/screens/NurseReportingHome.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '/theme/colors/light_colors.dart';

class DashboardScreenNurse extends StatefulWidget{
  static String TAG ="dashboardNurse";
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DashboardScreenNurseState();
  }
  
}
class DashboardScreenNurseState extends State<DashboardScreenNurse>{


  var lstOptions=[
    {
      "icon":"assets/images/add_session.png",
      "title":"Emergency Care"

    },
    {
      "icon":"assets/images/add_session.png",
      "title":"Reporting"

    },
    {
      "icon":"assets/images/add_session.png",
      "title":"Staffing "

    },
    {
      "icon":"assets/images/add_session.png",
      "title":"Control"

    },

    {
      "icon":"assets/images/add_session.png",
      "title":"Overall Objectives "

    },
    {
      "icon":"assets/images/add_session.png",
      "title":"My Profile"

    }

  ];


  Widget _getDashboardHeader()
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: LightColors.kLightYellow,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text("Nursing and Public Health ----Home", style: TextStyle(color: LightColors.kRed ,),),
              actions: [
                IconButton(icon: Icon(Icons.search, color: Colors.grey,), onPressed: () {}),

              ],

            ),

          )),
    );
  }


  Widget _getDashboardBody()
  {
    return StaggeredGridView.countBuilder(crossAxisCount: 3,

        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        primary: true,

        itemCount: lstOptions.length,
        itemBuilder: (_,index){
           return InkWell(
             onTap: (){
               if(index==0)
                 {
                   Navigator.pushNamed(context,EmergencyCare.TAG);
                 }
               else if(index==1)
                 {
                   Navigator.pushNamed(context,NurseReportingHome.TAG);
                 }

             },
             child: Padding(
              padding: const EdgeInsets.all(6.0),

                child: Container
                  (
                  decoration: BoxDecoration(
                    color:  LightColors.kPalePink,

                      borderRadius: BorderRadius.all(Radius.circular(0))
                  ),

                  height: 200,

                  child: Padding(

                    padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                    child: Column(

                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(image: AssetImage(lstOptions[index]["icon"]!)),
                        Spacer(),
                        Column(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(lstOptions[index]["title"]!,style: TextStyle( fontSize: 16.0,color: LightColors.kRed,fontWeight: FontWeight.bold),),

                          ],
                        )
                      ],
                    ),
                  ),
              ),
          ),
           );
        },
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(1));

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: LightColors.kLightYellow2,
      body: Stack(
          children: [
            _getDashboardHeader(),

            Column(
              children: [
                SizedBox(height: 130,),
                Expanded(child: _getDashboardBody()),

              ],
            )
          ],
        ),
    );
  }
}