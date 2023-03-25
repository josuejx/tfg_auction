import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
}
