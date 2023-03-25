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
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          height: _loading ? 300 : 70,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Hero(
                tag: 'logo', child: Image.asset('assets/logo.png', height: 70)),
            if (_loading) const SizedBox(height: 20),
            FadeOut(
                animate: !_loading,
                child: const Center(child: CircularProgressIndicator()))
          ]),
        ),
      ),
    );
  }
}
