import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_auction/db/db_archivado.dart';
import 'package:tfg_auction/models/archivado.dart';
import 'package:tfg_auction/models/usuario.dart';
import 'package:tfg_auction/session.dart';

class BotonArchivar extends StatefulWidget {
  int idProducto;
  BotonArchivar({Key? key, required this.idProducto}) : super(key: key);

  @override
  State<BotonArchivar> createState() => _BotonArchivarState();
}

class _BotonArchivarState extends State<BotonArchivar> {
  bool _archivado = false;
  bool _logged = false;
  Archivado _archivadoModel = Archivado();

  @override
  void initState() {
    super.initState();
    _archivadoModel.idProducto = widget.idProducto;
    cargarUsuario();
  }

  void cargarUsuario() async {
    Usuario? usuario = await Session().getSession();

    if (usuario != null) {
      Archivado archivado = await DBArchivado().readByUserAndProduct(
        usuario.id!,
        widget.idProducto,
      );
      setState(() {
        _archivadoModel.idUsuario = usuario.id;
        _archivado = archivado.id != null;
        _logged = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _logged
        ? IconButton(
            icon: Icon(
              _archivado ? Icons.archive : Icons.archive_outlined,
              color: _archivado ? Colors.blue : Colors.black,
            ),
            onPressed: () async {
              _archivado = !_archivado;
              if (_archivado) {
                String result = await DBArchivado().create(_archivadoModel);
                if (result != "") {
                  Get.snackbar('Error al archivar el producto', result,
                      backgroundColor: Colors.red, colorText: Colors.white);
                  return;
                }
              } else {
                _archivadoModel = await DBArchivado().readByUserAndProduct(
                  _archivadoModel.idUsuario!,
                  _archivadoModel.idProducto!,
                );
                await DBArchivado().delete(_archivadoModel.id!);
              }
              setState(() {
                Get.rawSnackbar(
                  message: _archivado ? 'Producto archivado' : 'Desarchivado',
                  duration: const Duration(seconds: 1),
                  backgroundColor: _archivado ? Colors.blue : Colors.black,
                );
              });
            },
          )
        : IconButton(
            icon: const Icon(
              Icons.archive_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Get.rawSnackbar(
                message: 'Debes iniciar sesión para archivar',
                duration: const Duration(seconds: 1),
                backgroundColor: Colors.black,
              );
            },
          );
  }
}
