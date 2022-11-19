import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:status_app/screens/business_detail_screen.dart';
import 'package:status_app/screens/login_screen.dart';
import 'package:status_app/screens/register_screen.dart';
import 'package:status_app/screens/splash_screen.dart';
import 'package:status_app/screens/success_screen.dart';
import 'package:status_app/screens/user_type_screen.dart';
import 'screens/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var routes=<String,WidgetBuilder>{
      '/home': (context)=>const HomeScreen(),
      '/login': (context)=> const LoginScreen(),
      '/register': (context)=> const RegisterScreen(),
      '/type': (context)=> UserTypeScreen(),
      '/detail': (context)=> BusinessDetailScreen(),
      '/splash': (context)=> SplashScreen(),
    };
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      initialRoute: '/splash',
      debugShowCheckedModeBanner: false,
    );
  }
}
