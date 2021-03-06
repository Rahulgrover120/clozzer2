import 'package:clozzr/screens/authentication.dart';
import 'package:clozzr/screens/dashboard.dart';
import 'package:clozzr/screens/verifyOTP.dart';
import 'package:clozzr/screens/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xFF949DFF),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, snapshot) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Clozzr',
        theme: ThemeData(
          primaryColor: const Color(0xFF949DFF),
        ),
        home: Dashboard(),
        // initialRoute: '/',
        // routes: {
        //   '/': (context) => const Welcome(),
        //   'auth': (context) => const Auth(),
        //   'verifyOTP': (context) => const Verify(),
        //   'dashboard': (context) => const Dashboard(),
        // },
      );
    });
  }
}
