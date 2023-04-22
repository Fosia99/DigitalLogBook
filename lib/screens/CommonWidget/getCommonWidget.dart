
import 'package:flutter/material.dart';

import '/AppConfig.dart';
import '/theme/colors/light_colors.dart';

Widget getUserCredentialsHeader(BuildContext context,{required String heading,required String details})
{
  return Container(

      height: 220,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 48.0,),
         //  Image(image: AssetImage("assets/images/logo.png"),height: 48.0,width: 48.0,),
            SizedBox(height: 16.0,),
            Text(heading, style: TextStyle(color: Colors.white, fontSize: 32.0),),
            SizedBox(height: 8.0,),
            Text(details, style: TextStyle(color: Colors.white, fontSize: 16.0),)
          ],
        ),
      ),
      decoration: BoxDecoration(
         color: LightColors.kGreen ,

      ));
}

Widget getDoctorCard(Map doctor)
{
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Image(
                    image:
                    AssetImage(doctor["doctor_image"]),
                    height: 64.0,
                    width: 64.0,
                  ),
                  flex: 1,
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(doctor["doctor_name"]),
                            Spacer(),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star,
                                  color:
                                  AppConfig.splashBackgroundColor,
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  doctor["doctor_rating"],
                                  style: TextStyle(
                                      color: AppConfig
                                          .splashBackgroundColor),
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              doctor["doctor_speciality"],
                              style: TextStyle(color: Colors.grey),
                            ),
                            Spacer(),
                            Text(
                              "(" +
                                  doctor["doctor_review"] +
                                  ")",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              doctor["doctor_distance"],
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Divider(
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.videocam,
                  color: AppConfig.splashBackgroundColor,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: AppConfig.splashBackgroundColor,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Icon(
                      Icons.textsms,
                      color: AppConfig.splashBackgroundColor,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Widget getSocialWidget()
{
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Padding(padding: const EdgeInsets.only(bottom: 16.0),
        child: Text("OR",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),

      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child: Image(image: AssetImage("assets/images/google.png")),
            onTap: (){},
          ),
          SizedBox(width: 16.0,),
          InkWell(
            child: Image(image: AssetImage("assets/images/facebook.png")),
            onTap: (){},
          ),
          SizedBox(width: 16.0,),
          InkWell(
            child: Image(image: AssetImage("assets/images/twitter.png")),
            onTap: (){},
          ),

        ],
      )

    ],
  );
}

