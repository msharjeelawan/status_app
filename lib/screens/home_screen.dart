import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:status_app/helper/constant.dart';
import 'package:status_app/screens/status_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  var tabController;
  var tabViewList=<Widget>[];
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2,vsync: this);
    tabViewList.add(English());
    tabViewList.add(Urdu());
    //
    // FirebaseFirestore.instance.collection("status").get().then((snap){
    //  QueryDocumentSnapshot docs =  snap.docs[0];
    //   print(docs.data());
    // }).catchError((e){
    //   print(e);
    // });

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Home"),
        titleTextStyle: const TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),
        centerTitle: true,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark
        ),
        actions: [
          IconButton(onPressed: (){
            var user = FirebaseAuth.instance.currentUser;
            if(user!=null){
              FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            }
          }, icon: const Icon(Icons.logout,color: Colors.black,))
        ],
      ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: greyColor),
                  borderRadius: BorderRadius.circular(30)
                ),
                child: TabBar(
                  controller: tabController,
                  labelColor: primaryColor,
                  unselectedLabelColor: greyColor,
                  indicator: const UnderlineTabIndicator(borderSide: BorderSide.none),
                  labelStyle: TextStyle(color: primaryColor),
                  tabs: const [
                    Tab(text: "English",),
                    Tab(text: "Urdu",)
                  ],
                ),
              ),
              Flexible(
                child: TabBarView(
                  controller: tabController,
                    children: tabViewList
                ),
              )
            ],
          ),
        )
    );
  }
}

class English extends StatelessWidget {
  const English({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    return Column(
      children: [
        Expanded(
          child: Container(
            width: width,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black12
            ),
            child: Center(
                child: TextButton(
                  child: Text("Islamic",style: TextStyle(color: blackTextColor,fontSize: 25,fontWeight: FontWeight.bold),),
                  onPressed: () {
                    var route = MaterialPageRoute(builder: (context){
                      return StatusScreen(index: categoriesIndex["IslamicEng"]!,);
                    });
                    Navigator.push(context, route);
                    }
                ,)
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: width,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black12
            ),
            child: Center(
                child: TextButton(
                  child: Text("Hadees",style: TextStyle(color: blackTextColor,fontSize: 25,fontWeight: FontWeight.bold),),
                  onPressed: () {
                    var route = MaterialPageRoute(builder: (context){
                      return StatusScreen(index: categoriesIndex["HadeesEng"]!,);
                    });
                    Navigator.push(context, route);
                  }
                  ,)
            ),
            ),
        ),
        Expanded(
          child: Container(
            width: width,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black12
            ),
            child: Center(
                child: TextButton(
                  child: Text("Quotes",style: TextStyle(color: blackTextColor,fontSize: 25,fontWeight: FontWeight.bold),),
                  onPressed: () {
                    var route = MaterialPageRoute(builder: (context){
                      return StatusScreen(index: categoriesIndex["QuotesEng"]!,);
                    });
                    Navigator.push(context, route);
                  }
                  ,)
            ),
            ),
        ),
        Expanded(
          child: Container(
            width: width,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black12
            ),
            child: Center(
                child: TextButton(
                  child: Text("Pakistan",style: TextStyle(color: blackTextColor,fontSize: 25,fontWeight: FontWeight.bold),),
                  onPressed: () {
                    var route = MaterialPageRoute(builder: (context){
                      return StatusScreen(index: categoriesIndex["PakistanEng"]!,);
                    });
                    Navigator.push(context, route);
                  }
                  ,)
            ),
          ),
        )
      ],
    );
  }
}

class Urdu extends StatelessWidget {
  const Urdu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    return Column(
      children: [
        Expanded(
          child: Container(
            width: width,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black12
            ),
            child: Center(
                child: TextButton(
                  child: Text("Islamic",style: TextStyle(color: blackTextColor,fontSize: 25,fontWeight: FontWeight.bold),),
                  onPressed: () {
                    var route = MaterialPageRoute(builder: (context){
                      return StatusScreen(index: categoriesIndex["IslamicUrdu"]!,);
                    });
                    Navigator.push(context, route);
                  }
                  ,)
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: width,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black12
            ),
            child: Center(
                child: TextButton(
                  child: Text("Hadees",style: TextStyle(color: blackTextColor,fontSize: 25,fontWeight: FontWeight.bold),),
                  onPressed: () {
                    var route = MaterialPageRoute(builder: (context){
                      return StatusScreen(index: categoriesIndex["HadeesUrdu"]!,);
                    });
                    Navigator.push(context, route);
                  }
                  ,)
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: width,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black12
            ),
            child: Center(
                child: TextButton(
                  child: Text("Quotes",style: TextStyle(color: blackTextColor,fontSize: 25,fontWeight: FontWeight.bold),),
                  onPressed: () {
                    var route = MaterialPageRoute(builder: (context){
                      return StatusScreen(index: categoriesIndex["QuotesUrdu"]!,);
                    });
                    Navigator.push(context, route);
                  }
                  ,)
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: width,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black12
            ),
            child: Center(
                child: TextButton(
                  child: Text("Pakistan",style: TextStyle(color: blackTextColor,fontSize: 25,fontWeight: FontWeight.bold),),
                  onPressed: () {
                    var route = MaterialPageRoute(builder: (context){
                      return StatusScreen(index: categoriesIndex["PakistanUrdu"]!,);
                    });
                    Navigator.push(context, route);
                  }
                  ,)
            ),
          ),
        )
      ],
    );
  }
}
