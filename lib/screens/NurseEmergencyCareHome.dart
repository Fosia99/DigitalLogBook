
import 'package:flutter/material.dart';
import '/AppConfig.dart';



import '/theme/colors/light_colors.dart';
import 'ClinicListScreen.dart';
import 'LogSession.dart';

class EmergencyCare extends StatefulWidget{
  static String TAG="emergencyCare";
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EmergencyCareState();
  }

}
class EmergencyCareState extends State<EmergencyCare>{

  var lstClinic=[
    {
      "clinic_image":"assets/images/clinic_image.png",
      "procedure_name":"Operating A Defibrillator",
      "procedure_frequency":"Twice"

    },
    {
      "clinic_image":"assets/images/clinic_image.png",
      "procedure_name":"Performing Triage ",
      "procedure_frequency":"Three Times"
    },
    {
      "clinic_image":"assets/images/clinic_image.png",
      "procedure_name":"Ward/hospital Emergency Plan ",
      "procedure_frequency":"Once"
    },
    {
      "clinic_image":"assets/images/clinic_image.png",
      "procedure_name":"Cardio-Pulmonary Resuscitation",
      "procedure_frequency":"Twice"
    },
    {
      "clinic_image":"assets/images/clinic_image.png",
      "procedure_name":"Disaster Planning ",
      "procedure_frequency":"Twice"
    },
    {
      "clinic_image":"assets/images/clinic_image.png",
      "procedure_name":"Design an Infection Control Plan for the Unit ",
      "procedure_frequency":"Twice"
    },
    {
      "clinic_image":"assets/images/clinic_image.png",
      "procedure_name":"Emergency Trolley Control  ",
      "procedure_frequency":"Three Times"
    },
    {
      "clinic_image":"assets/images/clinic_image.png",
      "procedure_name":"Insertion of Intravenous Cannula  ",
      "procedure_frequency":"Five Times"
    },
    {
      "clinic_image":"assets/images/clinic_image.png",
      "procedure_name":"Setting up a CPAP Machine ",
      "procedure_frequency":"Twice"
    },
    {
      "clinic_image":"assets/images/clinic_image.png",
      "procedure_name":"Nursing a Patient on a Ventilator  ",
      "procedure_frequency":"Twice"
    }
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.kDarkYellow,
        title: Text("PROCEDURES"),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: (){}),

        ],
      ),


      body: Container(

        height: 900,

        color: LightColors.kLightYellow,
        padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0,top:16),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
            itemCount: lstClinic.length,
            itemBuilder: (_,index){
              return InkWell(
                onTap: (){
                  if(index==0)
                  {

                  }
                  else if(index==1)
                  {
                   // Navigator.pushNamed(context,PerformingTriage.TAG);
                  }
                  else if(index==2)
                  {
                  //  Navigator.pushNamed(context,PerformingTriage.TAG);
                  }
                },

             child: Padding(padding: const EdgeInsets.only(top: 2.0),
              child: Card(

              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),),
                elevation: 10,

                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.adjust_rounded, size:40, color: LightColors.kDarkYellow,),
                                Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row (
                                      children: [
                                        Text( " "),
                                      ],

                                    ),
                                    Row(
                                      children: [
                                        Text( " "),
                                        Text('    '+  lstClinic[index]["procedure_name"]!.toUpperCase()
                                          ,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0,),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text( " ")
                                      ],
                                    ),
                                    SizedBox(height: 2.0,),

                                  ],
                                )
                              ],
                            ),

                          ],
                        ),
                        SizedBox(height: 8.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                SizedBox(width: 16.0,),

                              ],
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
              )
              ),
              );
            }),
      ),
    );
  }

}