import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:status_app/helper/constant.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  bool isObscure = true;
  String email="";
  String password="";
  String fullName="";


  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.cancel,color: greyColor,)
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Sign Up",style: TextStyle(color: Colors.black,fontSize: 20),),
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark
        ),
        actions: [
          TextButton(
              onPressed: (){
               /// Navigator.pushNamed(context,'/login');
                Navigator.pop(context);
              },
              child: Text("Login",style: TextStyle(color: primaryColor),)
          )
        ],
      ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            height: height*0.86,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Image.asset("assets/images/logo.png",width: width,height: 300,),
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: (name){
                       if(name!=null){
                         if(name.isEmpty){
                           return "Please enter name";
                         }else if(name.length<5){
                           return "Please enter full name";
                         }
                       }
                      },
                      onSaved: (name){
                        fullName=name!;
                      },
                      decoration: InputDecoration(
                        fillColor: inputBG,
                        filled: true,
                        hintText: "Name",
                        labelText: "Name",
                        contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide()
                        )
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (email){
                        if(email!=null){
                          if(email.isEmpty){
                            return "Please enter email";
                          }else if(!email.contains("@") || !email.contains(".") ){
                            return "Please enter valid email";
                          }
                        }
                      },
                      onSaved: (email){
                        this.email=email!;
                      },
                      decoration: InputDecoration(
                          fillColor: inputBG,
                          filled: true,
                          hintText: "Email",
                          labelText: "Email",
                          contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide()
                          )
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      obscureText: isObscure,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      validator: (password){
                        if(password!=null){
                          if(password.isEmpty){
                            return "Please enter password";
                          }else if(password.length<6){
                            return "Your password is short, Please enter  long password";
                          }
                        }
                      },
                      onSaved: (password){
                        this.password=password!;
                      },
                      decoration: InputDecoration(
                          fillColor: inputBG,
                          filled: true,
                          hintText: "Password",
                          labelText: "Password",
                          contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          //suffixStyle: TextStyle(color: primaryColor),
                          suffixIcon: SizedBox(
                            width: 70,
                            height: 50,
                            child: Center(
                              child: GestureDetector(
                                child: Text("Show", style: TextStyle(color: primaryColor),),
                                onTap: (){
                                  isObscure=!isObscure;
                                  setState(() {

                                  });
                                },
                              ),
                            ),
                          ),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide()
                          )
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      height: 20,
                      width: width,
                      child: ElevatedButton(
                          onPressed: (){
                            register(context);
                          },
                          child: const Text("Sign Up"),
                        style: ButtonStyle(
                         // fixedSize:  MaterialStateProperty.all(Size(width, 20)),
                          // minimumSize: MaterialStateProperty.all(Size(width, 20)),
                          // maximumSize: MaterialStateProperty.all(Size(width, 40)),
                           // padding: MaterialStateProperty.all(EdgeInsets.zero),
                          backgroundColor: MaterialStateProperty.all(primaryColor),
                          shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))))
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: (){

                      },
                      child: Text("Skip",style: TextStyle(color: primaryColor),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }


  void register(context){
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((userCredential) {
        var user = userCredential.user;
        if(user!=null){
         /// user.updateDisplayName(userType);
          FirebaseFirestore.instance.collection("users").add({"id":user.uid,"email":email,"fullName":fullName}).then((value) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Registered Successfully")));
            Navigator.pushReplacementNamed(context, '/type');
          });
        }
      }).catchError((e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      });
    }
  }
}
