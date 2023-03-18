import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:tfg_auction/db/db_general.dart';
import 'package:tfg_auction/db/db_usuario.dart';
import 'package:tfg_auction/db/env.dart';
import 'package:tfg_auction/models/usuario.dart';
import 'package:tfg_auction/screens/login_screen.dart';
import 'package:tfg_auction/screens/new_product_screen.dart';
import 'package:tfg_auction/screens/profile_screen.dart';
import 'package:tfg_auction/screens/register_screen.dart';
import 'package:tfg_auction/session.dart';

class AuctiOnDrawer extends StatefulWidget {
  final Widget child;
  static AdvancedDrawerController drawerController = AdvancedDrawerController();

  const AuctiOnDrawer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<AuctiOnDrawer> createState() => _AuctiOnDrawerState();
}

class _AuctiOnDrawerState extends State<AuctiOnDrawer> {
  bool _isLogged = false;
  Usuario? _usuario;

  @override
  void initState() {
    super.initState();
    AuctiOnDrawer.drawerController = AdvancedDrawerController();
    Session().getSession().then((Usuario? usuario) {
      if (usuario != null) {
        setState(() {
          _isLogged = true;
          _usuario = usuario;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Colors.blue,
      controller: AuctiOnDrawer.drawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0.0,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 24.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: _isLogged
                      ? getUserImage()
                      : const Icon(Icons.account_circle_rounded,
                          color: Colors.white, size: 128.0),
                ),
                if (_isLogged)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      '¡Hola, ${_usuario!.nombreUsuario}!',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                if (_isLogged) ...menuConSesionIniciada(),
                if (!_isLogged) ...menuSinSesion(),
                const Spacer(),
                if (_isLogged)
                  ListTile(
                    onTap: () {
                      Session().logout();
                      AuctiOnDrawer.drawerController.hideDrawer();
                      Get.offAllNamed('/home');
                    },
                    leading: const Icon(Icons.logout),
                    title: const Text('Cerrar sesión'),
                  ),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: const Text('Terms of Service | Privacy Policy'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: widget.child,
    );
  }

  List<Widget> menuConSesionIniciada() {
    return [
      ListTile(
        onTap: () {
          Get.to(() => ProfileScreen(usuario: _usuario!),
              transition: Transition.cupertino);
        },
        leading: const Icon(Icons.account_circle_rounded),
        title: const Text('Perfil'),
      ),
      ListTile(
        onTap: () {
          Get.to(() => const NewProductScreen(),
              transition: Transition.cupertino);
        },
        leading: const Icon(Icons.add),
        title: const Text('Crear subasta'),
      ),
    ];
  }

  List<Widget> menuSinSesion() {
    return [
      ListTile(
        onTap: () {
          Get.to(() => LoginScreen(), transition: Transition.cupertino);
        },
        leading: const Icon(Icons.login),
        title: const Text('Iniciar sesión'),
      ),
      ListTile(
          onTap: () {
            Get.to(() => RegisterScreen(), transition: Transition.cupertino);
          },
          leading: const Icon(Icons.account_circle_sharp),
          title: const Text('Registrarse')),
    ];
  }

  Widget getUserImage() {
    try {
      String url = DBUsuario().getImage(_usuario!.id!);
      return Image.network(url);
    } catch (e) {
      return const Icon(Icons.account_circle_rounded,
          color: Colors.white, size: 128.0);
    }
  }
}
