import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:status_app/helper/constant.dart';
import 'package:status_app/models/business_detail_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formState=GlobalKey<FormState>();
  bool isObscure = true;
  String email="";
  String password="";

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){},
            icon: Icon(Icons.cancel,color: greyColor,)
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Login",style: TextStyle(color: Colors.black,fontSize: 20),),
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark
        ),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.pushNamed(context,'/register');
              },
              child: Text("Sign Up",style: TextStyle(color: primaryColor),)
          )
        ],
      ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            height: height*0.86,
            child: Form(
              key: formState,
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Image.asset("assets/images/logo.png",width: width,height: 300,),
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (email){
                        if(email!=null){
                          if(email.isEmpty){
                            return "Please enter email";
                          }else if(email.contains("@")==false || email.contains(".")==false ){
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
                      width: width,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ElevatedButton(
                          onPressed: (){
                            signIn(context);
                          },
                          child: const Text("Sign In"),
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

  void signIn(context) async {
    if (formState.currentState!.validate()) {
      formState.currentState!.save();
      var auth = FirebaseAuth.instance;
      auth.signInWithEmailAndPassword(email: email, password: password)
          .then((credential){
        var user=credential.user;
        if(user!=null) {
          showDialog(
              context: context, barrierDismissible: false, builder: (context) {
            return AlertDialog(
              title: const Text("Please wait"),
              content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator()
                  ]
              ),
            );
          });
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Login Successfully")));
          Navigator.pushNamedAndRemoveUntil(context, '/home',(route)=> false);
          
          FirebaseFirestore.instance.collection("businessDetail").doc(user.uid).get().then((document) {
            var map=document.data();
            BusinessDetailModel.fromJsonToModel(map);
            BusinessDetailModel.hasBusinessDetail=true;
          }).catchError((e){
            BusinessDetailModel.hasBusinessDetail=false;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
          });
          
        }
      }).catchError((e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      });
    }
  }
}
