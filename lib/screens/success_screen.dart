import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:status_app/helper/constant.dart';

class SuccessScreen extends StatefulWidget {
  String type;
  SuccessScreen({Key? key,required this.type}) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Success",style: TextStyle(color: Colors.black,fontSize: 20),),
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
            child: Column(
              children: [
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                  width: width*0.6,
                  height: height*0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    border: Border.all(color: primaryColor)
                  ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Success"),
                          Text("status ${widget.type}"),
                        ],
                      ),
                )),
                Expanded(
                  child: Container(
                    height: 32,
                    width: width,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: ElevatedButton(
                        onPressed: (){

                        },
                        child: const Text("Rate us"),
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
                      Navigator.pop(context);
                    },
                    child: Text("Back",style: TextStyle(color: primaryColor),),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

}
