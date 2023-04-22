
import 'package:flutter/material.dart';
import '/AppConfig.dart';
import '/theme/colors/light_colors.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({Key ?key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenState();
  }

}

class SplashScreenState extends State<SplashScreen>
  {

  startTime() async {
    var _duration = new Duration(seconds: 5000);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 32.0,top: 64.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome",style: TextStyle(fontSize: 32,color:LightColors.kGreen),),
                Text("to Your Digital LogBook",style: TextStyle(fontSize: 32,color: Colors.black),),
                SizedBox(height: 16.0,),
                Text("   ,",style: TextStyle(color: Colors.grey,fontSize: 16.0),),


                SizedBox(height: 32.0,),
                Image(image: AssetImage("assets/images/slide1.png"),),
              ],
            ),
          ),
          Container(
            child: Padding(padding: const EdgeInsets.only(top: 40.0,right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("",style: TextStyle(color: AppConfig.splashBackgroundColor),),
                  ],
                )),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              child: Padding(padding: const EdgeInsets.only(bottom: 32.0,right: 16.0),
                child: IconButton(icon: Icon(Icons.arrow_forward,color: LightColors.kGreen,size: 32.0,),color: LightColors.kGreen, onPressed: (){

                }),),
            ),
          )
        ],
      ),
    );
  }
}

