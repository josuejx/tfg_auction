import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tfg_auction/db/db_usuario.dart';
import 'package:tfg_auction/models/usuario.dart';
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
                  Get.dialog(
                    const AlertDialog(
                      content: Text('Iniciando sesión...'),
                    ),
                    barrierDismissible: false,
                  );
                  await Auth().signInWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text);

                  Usuario usuario =
                      await DBUsuario().read(_emailController.text);
                  await DBUsuario().puntuacionUsuario(usuario);

                  Get.offAll(() => HomeScreen(), transition: Transition.fade);
                  Get.snackbar(
                      'Bienvenido', 'Has iniciado sesión correctamente',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green,
                      colorText: Colors.white);
                } on FirebaseAuthException catch (e) {
                  Get.back();
                  Get.snackbar('Error', e.message!,
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white);
                }
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(
                    MediaQuery.of(context).size.width * 0.4 > 120
                        ? MediaQuery.of(context).size.width * 0.4
                        : 120,
                    40),
              ),
              child: const Text('Iniciar Sesión'),
            ),
            if (!GetPlatform.isIOS) const SizedBox(height: 10),
            if (!GetPlatform.isIOS)
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 10.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 36,
                      ),
                    ),
                  ),
                  const Text('O'),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 36,
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 10),
            if (!GetPlatform.isIOS)
              ElevatedButton.icon(
                  onPressed: () async {
                    await Auth().googleSignIn();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  icon:
                      const FaIcon(FontAwesomeIcons.google, color: Colors.red),
                  label: const Text('Iniciar sesión con Google')),
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
