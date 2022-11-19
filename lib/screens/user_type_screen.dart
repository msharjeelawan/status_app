import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:status_app/helper/constant.dart';

class UserTypeScreen extends StatefulWidget {
  const UserTypeScreen({Key? key}) : super(key: key);

  @override
  State<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
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
        title: const Text("Type",style: TextStyle(color: Colors.black,fontSize: 20),),
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark
        ),
      ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            height: height*0.86,
            child: Form(
              child: Column(
                children: [
                  const Expanded(
                    flex: 3,
                    child: SizedBox(),
                  ),
                  const Expanded(
                    child: Text("Get the daily status for yourself or business"),
                  ),
                  Expanded(
                    child: Container(
                      width: width,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ElevatedButton(
                        onPressed: (){
                          updateUserType("personal");
                        },
                        child: const Text("Self"),
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
                    child: Container(
                      width: width,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ElevatedButton(
                        onPressed: (){
                          updateUserType("business");
                        },
                        child: const Text("Business"),
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

  void updateUserType(String type){
    var user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection("users").where("id",isEqualTo: user!.uid).get().then((query) {
      var docs = query.docs;
      if(docs.isNotEmpty){
        var document = docs[0];
        document.reference.update({"type": type}).then((value) {
          if(type=="business"){
            Navigator.pushReplacementNamed(context, '/detail');
          }else{
            Navigator.pushReplacementNamed(context, '/home');
          }
        }).catchError((e){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
        });
      }
    }).catchError((e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    });
  }
}
