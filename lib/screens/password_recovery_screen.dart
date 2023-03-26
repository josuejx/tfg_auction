import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_auction/auth.dart';

class PasswordRecoveryScreen extends StatelessWidget {
  PasswordRecoveryScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
            tag: 'logo', child: Image.asset('assets/logo.png', height: 40)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(children: [
        const SizedBox(height: 20),
        const Text(
          'Recuperar contraseña',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        const Text(
          'Introduce tu correo electrónico y te enviaremos un enlace para que puedas restablecer tu contraseña.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Correo electrónico',
              border: OutlineInputBorder(),
            ),
            controller: emailController,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            onPressed: () async {
              try {
                Auth().sendPasswordResetEmail(email: emailController.text);
                Get.back();
                Get.snackbar('Enviado', 'Se ha enviado un enlace a tu correo',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white);
              } on FirebaseAuthException catch (e) {
                Get.snackbar('Error', e.message!,
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white);
              }
            },
            child: const Text('Enviar enlace'),
          ),
        ),
      ]),
    );
  }
}
