import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_auction/db/db_archivado.dart';
import 'package:tfg_auction/db/db_producto.dart';
import 'package:tfg_auction/db/db_usuario.dart';
import 'package:tfg_auction/models/archivado.dart';
import 'package:tfg_auction/models/producto.dart';
import 'package:tfg_auction/models/usuario.dart';
import 'package:tfg_auction/screens/request_login_screen.dart';
import 'package:tfg_auction/auth.dart';
import 'package:tfg_auction/widgets/product_card.dart';

class SavedContent extends StatefulWidget {
  const SavedContent({Key? key}) : super(key: key);

  @override
  State<SavedContent> createState() => _SavedContentState();
}

class _SavedContentState extends State<SavedContent> {
  List<Producto> _productos = [];
  Usuario? usuario;

  bool cargando = true;

  @override
  void initState() {
    cargarDatos();
    super.initState();
  }

  void cargarDatos() async {
    if (Auth().currentUser != null) {
      usuario = await DBUsuario().read((Auth().currentUser as User).uid);
      DBArchivado dbArchivado = DBArchivado();
      List<Archivado> archivados = await dbArchivado.readByUser(usuario!);
      for (var item in archivados) {
        Producto producto = await DBProducto().read(item.idProducto!);
        if (producto.id != null) {
          _productos.add(producto);
        }
      }
    }

    setState(() {
      cargando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (cargando) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (usuario == null) {
      return RequestLoginScreen();
    } else {
      return _productos.isEmpty
          ? const Center(
              child: Text('No hay productos'),
            )
          : SingleChildScrollView(
              child: GridView.count(
                crossAxisCount: MediaQuery.of(context).size.width / 300 > 2
                    ? (MediaQuery.of(context).size.width ~/ 300 > 5
                        ? 5
                        : MediaQuery.of(context).size.width ~/ 300)
                    : 1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                padding: const EdgeInsets.all(20),
                shrinkWrap: true,
                children: [
                  ..._productos
                      .map((e) => ZoomIn(child: ProductCard(producto: e)))
                      .toList(),
                ],
              ),
            );
    }
  }
}
