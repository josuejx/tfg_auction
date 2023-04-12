import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tfg_auction/db/db_producto.dart';
import 'package:tfg_auction/db/db_puja.dart';
import 'package:tfg_auction/models/producto.dart';
import 'package:tfg_auction/models/puja.dart';
import 'package:tfg_auction/models/usuario.dart';

class DBUsuario {
  Future<List<Usuario>> readAll() async {
    final docUser = FirebaseFirestore.instance.collection('usuarios').get();

    final doc = await docUser;

    final usuarios = <Usuario>[];

    doc.docs.forEach((element) {
      usuarios.add(Usuario.fromJson(element.data()));
    });

    return usuarios;
  }

  Future<Usuario> read(String email) async {
    final docUser =
        FirebaseFirestore.instance.collection('usuarios').doc(email).get();

    final doc = await docUser;

    if (doc.exists) {
      return Usuario.fromJson(doc.data()!);
    } else {
      return Usuario();
    }
  }

  Future save(Usuario usuario, File image) async {
    final docUser = FirebaseFirestore.instance
        .collection('usuarios')
        .doc('${usuario.email}');

    await docUser.set(usuario.toJson());

    final storageRef = FirebaseStorage.instance.ref('usuarios');

    if (image.path != "") {
      await storageRef.child('${usuario.email}').putFile(image);
    }
  }

  Future delete(Usuario usuario) async {
    final docUser = FirebaseFirestore.instance
        .collection('usuarios')
        .doc('${usuario.email}');

    await docUser.delete();

    final storageRef = FirebaseStorage.instance.ref('usuarios');

    await storageRef.child('${usuario.email}').delete();
  }

  Future<String> getImage(Usuario usuario) async {
    final storageRef = FirebaseStorage.instance.ref('usuarios');
    return await storageRef.child('${usuario.email}').getDownloadURL();
  }

  Future puntuacionUsuario(Usuario usuario) async {
    List<Puja> pujasUsuario = await DBPuja().readAllByUser(usuario);

    List<Producto> productosPujados = [];
    for (Puja puja in pujasUsuario) {
      productosPujados.add(await DBProducto().read(puja.idProducto!));
    }

    List<Producto> productosGanados = [];
    for (Producto producto in productosPujados) {
      var pujasProducto = pujasUsuario
          .where((element) => element.idProducto == producto.id)
          .toList();
      if (pujasProducto.length > 0) {
        var pujaMaxima = pujasProducto.reduce((value, element) =>
            value.cantidad! > element.cantidad! ? value : element);
        if (pujaMaxima.idUsuario == usuario.email) {
          productosGanados.add(producto);
        }
      }
    }

    List<Producto> productosPagados = [];
    for (Producto producto in productosGanados) {
      bool pagado = await DBProducto().isPagado(producto);
      if (pagado) {
        productosPagados.add(producto);
      }
    }

    double fiabilidad = 0;

    double mediaPujasProducto = pujasUsuario.length / productosPujados.length;

    if (productosPagados.isNotEmpty) {
      fiabilidad = (productosPagados.length) /
          (mediaPujasProducto *
              (productosGanados.length - productosPagados.length));
    }

    usuario.fiabilidad = fiabilidad;

    await save(usuario, File(""));
  }
}
