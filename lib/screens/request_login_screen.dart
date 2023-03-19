import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_auction/screens/login_screen.dart';
import 'package:tfg_auction/screens/register_screen.dart';

class RequestLoginScreen extends StatelessWidget {
  const RequestLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
            child:
                Text('Debes iniciar sesión', style: TextStyle(fontSize: 20))),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Get.to(() => LoginScreen(), transition: Transition.zoom);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fixedSize: const Size(200, 50),
          ),
          child: const Text('Login'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Get.to(() => RegisterScreen(), transition: Transition.zoom);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fixedSize: const Size(200, 50),
          ),
          child: const Text('Register'),
        ),
      ],
    );
  }
}
