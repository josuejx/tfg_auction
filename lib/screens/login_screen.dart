import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_auction/models/usuario.dart';
import 'package:tfg_auction/screens/home_screen.dart';
import 'package:tfg_auction/session.dart';

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
            tag: 'logo',
            child: Image.asset('assets/logo_fondo.png', height: 40)),
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
                bool test = await Session()
                    .login(_emailController.text, _passwordController.text);
                if (test) {
                  Usuario? usuario = await Session().getSession();
                  Get.snackbar(
                      'Login', 'Bienvenido de nuevo ${usuario!.nombreUsuario}',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green,
                      colorText: Colors.white);
                  Get.offAll(() => HomeScreen());
                } else {
                  setState(() {
                    _loading = false;
                  });
                  Get.snackbar('Login',
                      'Error al iniciar sesión. Comprueba tus credenciales.',
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
              onPressed: () {},
              child: const Text('¿Olvidaste tu contraseña?'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {},
              child: const Text('¿No tienes cuenta? Regístrate'),
            ),
          ],
        ),
      ),
    );
  }
}
