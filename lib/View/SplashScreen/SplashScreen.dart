import 'package:flutter/material.dart';

import '../HomeScree/HomeScreen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    //todo:implement your code here
    super.initState();
    navigateHome();
  }



  navigateHome()async{
   await Future.delayed(Duration(seconds: 2)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd99e57),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal:20),
                child: Image(
                  image: AssetImage("assets/images/splashimage.gif"),

                )
            ),
          ),
        ],
      ),
    );
  }
}
