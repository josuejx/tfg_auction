import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_auction/db/db_usuario.dart';
import 'package:tfg_auction/models/usuario.dart';
import 'package:tfg_auction/session.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _hidePassword = true;
  bool _hidePassword2 = true;

  // TextEditingControllers
  File _image = File('');
  final TextEditingController _nombreUsuarioController =
      TextEditingController();
  final TextEditingController _nombreCompletoController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAll(() => LoginScreen());
          },
        ),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Hero(
              tag: 'logo',
              child: Image.asset('assets/logo_fondo.png', height: 40)),
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1 > 30
                      ? MediaQuery.of(context).size.width * 0.1
                      : 30),
              child: Column(
                children: [...registerFormWidgets()],
              ))
        ],
      ),
    );
  }

  List<Widget> registerFormWidgets() {
    return [
      Stack(
        children: [
          Container(
            width: 128.0,
            height: 128.0,
            margin: const EdgeInsets.only(
              top: 24.0,
              bottom: 64.0,
            ),
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: Colors.black26,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.account_circle_rounded,
                color: Colors.white, size: 128.0),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                _image = File('');
              },
              child: Container(
                width: 48.0,
                height: 48.0,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.edit, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      TextField(
        decoration: const InputDecoration(
          hintText: 'Nombre de usuario',
        ),
        controller: _nombreUsuarioController,
      ),
      const SizedBox(height: 10),
      TextField(
        decoration: const InputDecoration(
          hintText: 'Nombre real',
        ),
        controller: _nombreCompletoController,
      ),
      const SizedBox(height: 10),
      TextField(
        decoration: const InputDecoration(
          hintText: 'Email',
        ),
        controller: _emailController,
      ),
      const SizedBox(height: 10),
      TextField(
        decoration: InputDecoration(
          hintText: 'Contraseña',
          suffix: IconButton(
            icon: _hidePassword
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off),
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
      const SizedBox(height: 10),
      TextField(
        decoration: InputDecoration(
          hintText: 'Repetir contraseña',
          suffix: IconButton(
            icon: _hidePassword2
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off),
            onPressed: () {
              setState(() {
                _hidePassword2 = !_hidePassword2;
              });
            },
          ),
        ),
        obscureText: _hidePassword2,
        controller: _password2Controller,
      ),
      const SizedBox(height: 30),
      ElevatedButton(
        onPressed: () async {
          if (_nombreUsuarioController.text == "") {
            Get.snackbar("Error", "El nombre de usuario no puede estar vacío",
                backgroundColor: Colors.red, colorText: Colors.white);
            return;
          }
          if (_nombreCompletoController.text == "") {
            Get.snackbar("Error", "El nombre completo no puede estar vacío",
                backgroundColor: Colors.red, colorText: Colors.white);
            return;
          }
          if (_emailController.text == "") {
            Get.snackbar("Error", "El email no puede estar vacío",
                backgroundColor: Colors.red, colorText: Colors.white);
            return;
          }
          if (_passwordController.text == "") {
            Get.snackbar("Error", "La contraseña no puede estar vacía",
                backgroundColor: Colors.red, colorText: Colors.white);
            return;
          }
          if (_password2Controller.text == "") {
            Get.snackbar("Error", "Debes volver a escribir la contraseña",
                backgroundColor: Colors.red, colorText: Colors.white);
            return;
          }
          if (_passwordController.text != _password2Controller.text) {
            Get.snackbar("Error", "Las contraseñas no coinciden",
                backgroundColor: Colors.red, colorText: Colors.white);
            return;
          }

          Usuario usuario = Usuario(
              nombreUsuario: _nombreUsuarioController.text,
              nombreCompleto: _nombreCompletoController.text,
              email: _emailController.text,
              password: _passwordController.text);

          String test = await DBUsuario().create(usuario);
          if (test == "") {
            Get.snackbar("Registro completado",
                "Usuario creado correctamente, ya puede iniciar sesión",
                backgroundColor: Colors.green, colorText: Colors.white);
            Get.off(() => LoginScreen());
          } else {
            Get.snackbar("Erro al crear el usuario", test,
                backgroundColor: Colors.red, colorText: Colors.white);
          }
        },
        child: const Text('Registrarse'),
      ),
      const SizedBox(height: 10),
      TextButton(
        onPressed: () {
          Get.off(() => LoginScreen());
        },
        child: const Text('¿Ya tienes cuenta?'),
      ),
    ];
  }
}
