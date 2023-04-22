
import 'package:flutter/material.dart';
import '/AppConfig.dart';

class ClinicListScreen extends StatefulWidget{
  static String TAG="cliniclist";
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ClinicListScreenState();
  }
  
}
class ClinicListScreenState extends State<ClinicListScreen>{

  var lstClinic=[
    {
      "clinic_image":"assets/images/clinic_image.png",
      "clinic_name":"Name of Clinic",
      "clinic_distance":"68km away",
      "clinic_rating":"4.7",
      "clinic_address":"987 Blaise Drive Suite 420"
    },
    {
      "clinic_image":"assets/images/clinic_image.png",
      "clinic_name":"Name of Clinic",
      "clinic_distance":"68km away",
      "clinic_rating":"4.7",
      "clinic_address":"987 Blaise Drive Suite 420"
    },
    {
      "clinic_image":"assets/images/clinic_image.png",
      "clinic_name":"Name of Clinic",
      "clinic_distance":"68km away",
      "clinic_rating":"4.7",
      "clinic_address":"987 Blaise Drive Suite 420"
    },
    {
      "clinic_image":"assets/images/clinic_image.png",
      "clinic_name":"Name of Clinic",
      "clinic_distance":"68km away",
      "clinic_rating":"4.7",
      "clinic_address":"987 Blaise Drive Suite 420"
    },
    {
      "clinic_image":"assets/images/clinic_image.png",
      "clinic_name":"Name of Clinic",
      "clinic_distance":"68km away",
      "clinic_rating":"4.7",
      "clinic_address":"987 Blaise Drive Suite 420"
    },
    {
      "clinic_image":"assets/images/clinic_image.png",
      "clinic_name":"Name of Clinic",
      "clinic_distance":"68km away",
      "clinic_rating":"4.7",
      "clinic_address":"987 Blaise Drive Suite 420"
    }
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConfig.splashBackgroundColor,
        title: Text("Clinics"),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: (){}),
          IconButton(icon: Icon(Icons.location_on), onPressed: (){}),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
            itemCount: lstClinic.length,
            itemBuilder: (_,index){
              return Padding(padding: const EdgeInsets.only(top: 8.0),
              child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image(image: AssetImage("assets/images/clinic_image.png"),height: 96.0,width: 96.0,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(lstClinic[index]["clinic_name"]!),
                                      ],
                                    ),

                                    SizedBox(height: 4.0,),
                                    Text(lstClinic[index]["clinic_distance"]!),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.star,color: AppConfig.splashBackgroundColor,),
                                Text(lstClinic[index]["clinic_rating"]!,style: TextStyle(color: AppConfig.splashBackgroundColor),)
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
                                Icon(Icons.location_on,color: Colors.grey,),
                                SizedBox(width: 16.0,),
                                Text(lstClinic[index]["clinic_address"]!)
                              ],
                            ),
                            Icon(Icons.arrow_forward,color: Colors.grey,)
                          ],
                        )
                      ],
                    ),
                  ),
              ),);
            }),
      ),
    );
  }
  
}