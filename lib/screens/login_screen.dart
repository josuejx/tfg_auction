import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _hidePassword = true;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Hero(
            tag: 'logo',
            child: Image.asset('assets/logo_fondo.png', height: 40)),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1 > 30
                  ? MediaQuery.of(context).size.width * 0.1
                  : 30),
          child: Column(
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.2 > 120
                          ? MediaQuery.of(context).size.width * 0.2
                          : 120,
                      40),
                ),
                child: const Text('Iniciar Sesión'),
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
        )
      ]),
    );
  }
}
