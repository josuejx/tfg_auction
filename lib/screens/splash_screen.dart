import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_auction/screens/home_screen.dart';
import 'package:tfg_auction/screens/login_screen.dart';
import 'package:tfg_auction/session.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _loading = false;
      });
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAll(() => HomeScreen());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Hero(
              tag: 'logo', child: Image.asset('assets/logo.png', height: 70)),
        ),
        const SizedBox(height: 20),
        if (_loading)
          const Center(
            child: CircularProgressIndicator(),
          ),
        if (!_loading)
          FadeOut(child: const Center(child: CircularProgressIndicator()))
      ]),
    );
  }
}
