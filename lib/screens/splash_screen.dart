import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    splashToOther(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        backgroundColor: Colors.white,
        elevation: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light
        ),
      ),
      body: Container(
        color: Colors.white,
        child:  Center(
          child: Image.asset("assets/images/logo.png"),
        ),
      ),
    );
  }

  splashToOther(context){
    var user = FirebaseAuth.instance.currentUser;
    Future.delayed(const Duration(milliseconds: 1000),() async{
       if(user!=null){
         Navigator.pushReplacementNamed(context, "/home");
      }else{
         Navigator.pushReplacementNamed(context, "/login");
       }
    });
  }
}
