import 'package:flutter/material.dart';
import 'package:tfg_auction/models/usuario.dart';

class ProfileScreen extends StatefulWidget {
  Usuario usuario;
  ProfileScreen({Key? key, required this.usuario}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // text editing controllers
  final TextEditingController _nombreUsuarioController =
      TextEditingController();

  final TextEditingController _nombreCompletoController =
      TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  void cargarDatos() {
    _nombreUsuarioController.text = widget.usuario.nombreUsuario!;
    _nombreCompletoController.text = widget.usuario.nombreCompleto!;
    _emailController.text = widget.usuario.email!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil del usuario'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: ListView(
                children: _buildFormProfile(),
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fixedSize: const Size(200, 50),
              ),
              child: const Text('Guardar', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFormProfile() {
    return [
      TextFormField(
        decoration: InputDecoration(
          labelText: 'Nombre de usuario',
          hintText: 'Nombre de usuario',
        ),
        controller: _nombreUsuarioController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduzca un nombre de usuario';
          }
          return null;
        },
      ),
      const SizedBox(height: 20),
      TextFormField(
        decoration: InputDecoration(
          labelText: 'Nombre completo',
          hintText: 'Nombre completo',
        ),
        controller: _nombreCompletoController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduzca un nombre';
          }
          return null;
        },
      ),
      const SizedBox(height: 20),
      TextFormField(
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'Email',
        ),
        controller: _emailController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduzca un email';
          }
          return null;
        },
      ),
    ];
  }
}
