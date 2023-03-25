import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tfg_auction/models/producto.dart';
import 'package:tfg_auction/models/usuario.dart';

class DBProducto {
  Future<List<Producto>> readAll() async {
    final docProducto =
        FirebaseFirestore.instance.collection('productos').get();

    final doc = await docProducto;

    final productos = <Producto>[];

    doc.docs.forEach((element) {
      productos.add(Producto.fromJson(element.data()));
    });

    return productos;
  }

  Future<List<Producto>> readByUser(Usuario usuario) async {
    final docProducto = FirebaseFirestore.instance
        .collection('productos')
        .where('idUsuario', isEqualTo: usuario.email)
        .get();

    final doc = await docProducto;

    final productos = <Producto>[];

    doc.docs.forEach((element) {
      productos.add(Producto.fromJson(element.data()));
    });

    return productos;
  }

  Future<List<String>> readByQuery(String nombreProducto) async {
    final docProducto = FirebaseFirestore.instance
        .collection('productos')
        .where('nombre', whereIn: [nombreProducto]).get();

    final doc = await docProducto;

    final productos = <String>[];

    doc.docs.forEach((element) {
      productos.add(element.data()['nombre']);
    });

    return productos;
  }

  Future<Producto> read(int idProducto) async {
    final docProducto = FirebaseFirestore.instance
        .collection('productos')
        .where('id', isEqualTo: idProducto)
        .get();

    final doc = await docProducto;

    final productos = <Producto>[];

    doc.docs.forEach((element) {
      productos.add(Producto.fromJson(element.data()));
    });

    return productos[0];
  }

  Future<Producto> readByUserAndName(
      String idUsuario, String nombreProducto) async {
    final docProducto = FirebaseFirestore.instance
        .collection('productos')
        .where('idUsuario', isEqualTo: idUsuario)
        .where('nombre', isEqualTo: nombreProducto)
        .get();

    final doc = await docProducto;

    final productos = <Producto>[];

    doc.docs.forEach((element) {
      productos.add(Producto.fromJson(element.data()));
    });

    return productos[0];
  }

  Future create(Producto producto, File image) async {
    final docProducto = FirebaseFirestore.instance.collection('productos');

    final doc = await docProducto.add(producto.toJson());

    final id = doc.id;

    final storageRef = FirebaseStorage.instance.ref('usuarios');

    if (image.path != "") {
      await storageRef.child(id).putFile(image);

      final url = await storageRef.child(id).getDownloadURL();

      await docProducto.doc(id).update({'imagen': url});
    }
  }

  Future<String> getImagen(Producto producto) async {
    final storageRef = FirebaseStorage.instance.ref('productos');

    final url =
        await storageRef.child(producto.imagen.toString()).getDownloadURL();

    return url;
  }
}
