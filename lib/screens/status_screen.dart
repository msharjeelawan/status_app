import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:status_app/models/status_model.dart';
import 'package:status_app/screens/success_screen.dart';

import '../helper/constant.dart';
import '../helper/custom_shape.dart';
import '../models/business_detail_model.dart';

class StatusScreen extends StatefulWidget {
  int index;
  StatusScreen({Key? key,required this.index}) : super(key: key);

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  ScreenshotController controller = ScreenshotController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // Future.delayed(const Duration(seconds: 20),() async{

      // final directory = (await getExternalStorageDirectory())?.path;
      // print(directory);
      // String fileName = DateTime.now().microsecondsSinceEpoch.toString()+'.png';
      // controller.captureAndSave('$directory!',fileName: fileName);
     //  controller.capture().then((image) async {
     //    if (image != null) {
     //      final directory = await getExternalStorageDirectory();
     //      final imagePath = await File('${directory?.path}/image.png').create();
     //      await imagePath.writeAsBytes(image);
     //
     //      /// Share Plugin
     //      //await Share.shareFiles([imagePath.path]);
     //    }
     //  }).catchError((e){
     //    print(e.toString());
     //  });
      

  //  });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.index);
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Status of the Day"),
        titleTextStyle: const TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),
        centerTitle: true,
        toolbarHeight: 30,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark
        ),
      ),
      body: Container(
      //  padding: const EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>?>(
          stream: FirebaseFirestore.instance.collection("status").where("category",isEqualTo: widget.index).snapshots(),
          builder: (context, snapshot) {
           // print(snapshot.data?.docs[0]);

            if(!snapshot.hasData){
              return const Center(child: CircularProgressIndicator(),);
            }
            if(snapshot.hasData && snapshot.data?.size!=0){
              StatusModel.fromJsonToModel(snapshot.data?.docs);
            }else{
              return const Center(
                child: Text("No Status Available"),
              );
            }
            return Column(
              children: [
                Screenshot(
                  controller: controller,
                  child: Container(
                    height: height*0.85,
                    color: Colors.white,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 2,
                          left: 0,
                          right: 0,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            height: height*0.15,
                            //width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all()
                            ),
                            child: Center(
                              child: Text(StatusModel().packet),
                            ),
                          ),
                        ),
                        Positioned(
                          top: height*0.17,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: height*0.08,
                                width: width*0.45,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all()
                                ),
                                child: Text(StatusModel().date),
                              ),
                              Container(
                                height: height*0.08,
                                width: width*0.45,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all()
                                ),
                                child: Text(StatusModel().date),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: height*0.29,
                          left: 0,
                          right: 0,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            height: height*0.13,
                            //width: 200,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all()
                            ),
                            child: Center(child: Text(StatusModel().reference)),
                          ),
                        ),
                        Positioned(
                          top: height*0.27,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: CustomPaint(
                              painter: CustomZShape(),
                            ),
                          ),
                        ),
                        Positioned(
                          top: height*0.46,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: height*0.3,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            //width: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all()
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(StatusModel().translation),
                                Text(StatusModel().translation),
                                Text(StatusModel().translation)
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: height*0.44,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: CustomPaint(
                              painter: CustomZShape(),
                            ),
                          ),
                        ),

                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child:   BusinessDetailModel.hasBusinessDetail? Container(
                            height: height*0.08,
                            //width: 200,
                            color: Colors.red,
                            padding: EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(BusinessDetailModel().name),
                                    Text(BusinessDetailModel().phone),
                                  ],
                                ),
                                Text(BusinessDetailModel().address),
                              ],
                            ),
                            // decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(20),
                            //     border: Border.all()
                            // ),
                          )
                              :
                          const SizedBox(width: 0,height: 0,)
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      height:32,
                      width: width*0.4,
                      child: ElevatedButton(
                        onPressed: (){
                          saveStatus();
                        },
                        child: const Text("Save"),
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
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      height:32,
                      width: width*0.4,
                      child: ElevatedButton(
                        onPressed: (){
                          share();
                        },
                        child: const Text("Share"),
                        style: ButtonStyle(
                          // fixedSize:  MaterialStateProperty.all(Size(width, 20)),
                          // minimumSize: MaterialStateProperty.all(Size(width, 20)),
                          // maximumSize: MaterialStateProperty.all(Size(width, 40)),
                          // padding: MaterialStateProperty.all(EdgeInsets.zero),
                            backgroundColor: MaterialStateProperty.all(primaryColor),
                            shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))))
                        ),
                      ),
                    )
                  ],
                )
              ],
            );
          }
        ),
      ),
    );
  }

  void saveStatus() async{
    final directory = (await getExternalStorageDirectory())?.path;
    String fileName = DateTime.now().microsecondsSinceEpoch.toString()+'.png';
    controller.captureAndSave('$directory',fileName: fileName);
    var route = MaterialPageRoute(builder: (context){
      return SuccessScreen(type: "saved");
    });
    Navigator.push(context, route);
  }

  void share() async{
    final directory = (await getExternalStorageDirectory())?.path;
    String fileName = DateTime.now().microsecondsSinceEpoch.toString()+'.png';
    controller.captureAndSave(directory!,fileName: fileName).then((path) async {
      print(path!);
      await Share.shareFiles([path]).then((value) {
        var route = MaterialPageRoute(builder: (context){
          return SuccessScreen(type: "shared");
        });
        Navigator.push(context, route);
      });
    }).catchError((e){
      print(e.toString());
    });
    // controller.capture().then((image) async {
    //   if(image!=null){
    //     var file = File.fromRawPath(image);
    //     await Share.shareFiles([file.path]);
    //     var route = MaterialPageRoute(builder: (context){
    //       return SuccessScreen(type: "shared");
    //     });
    //     Navigator.push(context, route);
    //   }
    // }).catchError((e){
    //   print(e.toString());
    // });
  }
}
