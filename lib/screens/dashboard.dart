import 'package:clozzr/tab_bar/myhealth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text("Daahboard"),
          ),
          bottomNavigationBar: menu(),
          body: TabBarView(
            children: [
              const Center(child: Text('Dashboard')),
              const Center(child: Text('My health')),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HealthApp(),
                      ),
                    );
                  },
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      height: 54,
                      width: 200,
                      child: const Text(
                        'Download health data',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

Widget menu() {
  return Container(
    // color: Colors.blue,
    child: const TabBar(
      labelColor: Colors.amber,
      unselectedLabelColor: Colors.grey,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorPadding: EdgeInsets.all(5.0),
      indicatorColor: Colors.blue,
      tabs: [
        Tab(
          text: "Home",
          icon: Icon(Icons.home),
        ),
        Tab(
          text: "My health",
          icon: Icon(Icons.pending),
        ),
        Tab(
          text: "Settings",
          icon: Icon(Icons.settings),
        ),
      ],
    ),
  );
}


















// body: Container(
// padding: const EdgeInsets.all(32),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// const Text("You are Logged in successfully", style: TextStyle(color: Colors.lightBlue, fontSize: 32),),
// const SizedBox(height: 16,),
// Text("${user.phoneNumber}", style: const TextStyle(color: Colors.grey, ),),
// ],
// ),