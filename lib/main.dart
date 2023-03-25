import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_auction/firebase_options.dart';
import 'package:tfg_auction/screens/home_screen.dart';
import 'package:tfg_auction/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future _initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AuctiOn',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 5,
          iconTheme: IconThemeData(color: Colors.black),
          foregroundColor: Colors.black,
        ),
      ),
      home: const SplashScreen(),
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
      ],
    );
  }
}
