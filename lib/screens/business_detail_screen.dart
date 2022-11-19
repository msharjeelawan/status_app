import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:status_app/helper/constant.dart';

class BusinessDetailScreen extends StatefulWidget {
  const BusinessDetailScreen({Key? key}) : super(key: key);

  @override
  State<BusinessDetailScreen> createState() => _BusinessDetailScreenState();
}

class _BusinessDetailScreenState extends State<BusinessDetailScreen> {
  final formKey = GlobalKey<FormState>();
  String b_name="",b_address="",b_phone="",b_type="",b_logo="";
  XFile? xFile;

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Business Detail",style: TextStyle(color: Colors.black,fontSize: 20),),
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
              key: formKey,
              child: Column(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: (name){
                        if(name!.isEmpty){
                          return "Please enter name";
                        }
                      },
                      onSaved: (name){
                        b_name=name!;
                      },
                      decoration: InputDecoration(
                          fillColor: inputBG,
                          filled: true,
                          hintText: "Business Name",
                          labelText: "Business Name",
                          contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide()
                          )
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: (address){
                        if(address!.isEmpty){
                          return "Please enter address";
                        }
                      },
                      onSaved: (address){
                        b_address=address!;
                      },
                      decoration: InputDecoration(
                          fillColor: inputBG,
                          filled: true,
                          hintText: "Business Address",
                          labelText: "Business Address",
                          contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide()
                          )
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: (phone){
                        if(phone!.isEmpty){
                          return "Please enter phone";
                        }
                      },
                      onSaved: (phone){
                        b_phone=phone!;
                      },
                      decoration: InputDecoration(
                          fillColor: inputBG,
                          filled: true,
                          hintText: "Business Phone",
                          labelText: "Business Phone",
                          contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide()
                          )
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: (business){
                        if(business!.isEmpty){
                          return "Please enter business type";
                        }
                      },
                      onSaved: (type){
                        b_type=type!;
                      },
                      decoration: InputDecoration(
                          fillColor: inputBG,
                          filled: true,
                          hintText: "Business Type",
                          labelText: "Business Type",
                          contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide()
                          )
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      obscureText: true,
                      readOnly: true,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          fillColor: inputBG,
                          filled: true,
                          hintText: "Business Logo",
                          labelText: "Business Logo",
                          contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          //suffixStyle: TextStyle(color: primaryColor),
                          suffixIcon: SizedBox(
                            width: 150,
                            height: 60,
                            child: Center(
                              child: ElevatedButton(
                                onPressed: (){
                                  pickImage();
                                },
                                child: const Text("Choose File"),
                                style: ButtonStyle(
                                  // fixedSize:  MaterialStateProperty.all(Size(width, 20)),
                                   minimumSize: MaterialStateProperty.all(Size(140, 50)),
                                  // maximumSize: MaterialStateProperty.all(Size(width, 40)),
                                  // padding: MaterialStateProperty.all(EdgeInsets.zero),
                                    backgroundColor: MaterialStateProperty.all(primaryColor),
                                    shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))))
                                ),
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
                            updateBusinessDetail();
                          },
                          child: const Text("Save Business"),
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
                      child: Text("Cancel",style: TextStyle(color: primaryColor),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }

  void updateBusinessDetail(){
    var user = FirebaseAuth.instance.currentUser;
    if(formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if(b_logo.isNotEmpty){
        var map={"name":b_name,"address":b_address,"phone":b_phone,"type":b_type,"logo":b_logo};
        FirebaseFirestore.instance.collection("businessDetail").doc(user!.uid).set(map).then((value) {
          Navigator.pushReplacementNamed(context, '/home');
        }).catchError((e){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
        });
      }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Logo is not selected")));
      }

    }
  }

  Future<void> pickImage() async {
    // print("pick file");
    final picker=ImagePicker();
    xFile = await  picker.pickImage(source: ImageSource.gallery);
    if(xFile!=null){
      File image = File(xFile!.path);
      var imageName=FirebaseAuth.instance.currentUser!.uid;
      //upload image in firebase storage and add image url in fb db
      TaskSnapshot snapshot = await FirebaseStorage.instance.ref("businessImages").child(imageName).putFile(image);
      b_logo = await snapshot.ref.getDownloadURL();
    }
  }

}
