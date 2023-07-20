import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_auction/firebase_options.dart';
import 'package:tfg_auction/screens/home_screen.dart';
import 'package:tfg_auction/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');
  //String? token = await messaging.getToken();
  //print('Token: $token');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      Get.snackbar(
        notification.title!,
        notification.body!,
        backgroundColor: Colors.white,
        colorText: Colors.blue,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
        icon: const Icon(
          Icons.notifications,
          color: Colors.black,
        ),
      );
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AuctiOn',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
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
