import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_auction/screens/home_screen.dart';
import 'package:tfg_auction/screens/password_recovery_screen.dart';
import 'package:tfg_auction/screens/register_screen.dart';
import 'package:tfg_auction/auth.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _hidePassword = true;
  bool _loading = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
            tag: 'logo', child: Image.asset('assets/logo.png', height: 40)),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1 > 30
                ? MediaQuery.of(context).size.width * 0.1
                : 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
              controller: _emailController,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Contraseña',
                suffix: IconButton(
                  icon: Icon(
                    _hidePassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _hidePassword = !_hidePassword;
                    });
                  },
                ),
              ),
              obscureText: _hidePassword,
              controller: _passwordController,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                if (_emailController.text.isEmpty ||
                    _passwordController.text.isEmpty) {
                  Get.snackbar('Error', 'Rellena todos los campos',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white);
                  return;
                }

                setState(() {
                  _loading = true;
                });

                try {
                  await Auth().signInWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text);

                  Get.offAll(() => HomeScreen(), transition: Transition.fade);
                  Get.snackbar(
                      'Bienvenido', 'Has iniciado sesión correctamente',
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
              style: ElevatedButton.styleFrom(
                fixedSize: Size(
                    MediaQuery.of(context).size.width * 0.2 > 120
                        ? MediaQuery.of(context).size.width * 0.2
                        : 120,
                    40),
              ),
              child: _loading
                  ? const CircularProgressIndicator()
                  : const Text('Iniciar Sesión'),
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () {
                Get.to(() => PasswordRecoveryScreen(),
                    transition: Transition.fade);
              },
              child: const Text('¿Olvidaste tu contraseña?'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Get.to(() => RegisterScreen(), transition: Transition.fade);
              },
              child: const Text('¿No tienes cuenta? Regístrate'),
            ),
          ],
        ),
      ),
    );
  }
}
