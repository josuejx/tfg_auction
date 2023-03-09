import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_auction/screens/home_screen.dart';

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
        child: _loading
            ? ZoomIn(
                child: const Image(
                    image: AssetImage('assets/logo_animado.gif'), height: 400),
              )
            : Hero(
                tag: 'logo',
                child: ZoomIn(
                    child: Image.asset('assets/logo_fondo.png', height: 70))),
      ),
    );
  }
}
