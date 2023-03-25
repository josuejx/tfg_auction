import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tfg_auction/models/archivado.dart';
import 'package:tfg_auction/models/usuario.dart';

class DBArchivado {
  Future<List<Archivado>> readAll() async {
    final docArchivado = FirebaseFirestore.instance
        .collection('archivados')
        .orderBy('fecha', descending: true)
        .get();

    final doc = await docArchivado;

    final archivados = <Archivado>[];

    doc.docs.forEach((element) {
      archivados.add(Archivado.fromJson(element.data()));
    });

    return archivados;
  }

  Future<List<Archivado>> readByUser(Usuario usuario) async {
    final docArchivado = FirebaseFirestore.instance
        .collection('archivados')
        .where('idUsuario', isEqualTo: usuario.email)
        .orderBy('fecha', descending: true)
        .get();

    final doc = await docArchivado;

    final archivados = <Archivado>[];

    doc.docs.forEach((element) {
      archivados.add(Archivado.fromJson(element.data()));
    });

    return archivados;
  }

  Future<Archivado> read(String idUsuario, int idProducto) async {
    final docArchivado = FirebaseFirestore.instance
        .collection('archivados')
        .where('idUsuario', isEqualTo: idUsuario)
        .where('idProducto', isEqualTo: idProducto)
        .get();

    final doc = await docArchivado;

    Archivado archivado = Archivado();

    doc.docs.forEach((element) {
      archivado = Archivado.fromJson(element.data());
    });

    return archivado;
  }

  Future create(Archivado archivado) async {
    final docArchivado = FirebaseFirestore.instance
        .collection('archivados')
        .where('idUsuario', isEqualTo: archivado.idUsuario)
        .where('idProducto', isEqualTo: archivado.idProducto)
        .get();

    final doc = await docArchivado;

    if (doc.docs.length == 0) {
      await FirebaseFirestore.instance
          .collection('archivados')
          .add(archivado.toJson());
    }

    return;
  }

  Future delete(int id) async {
    final docArchivado = FirebaseFirestore.instance
        .collection('archivados')
        .where('id', isEqualTo: id)
        .get();

    final doc = await docArchivado;

    doc.docs.forEach((element) {
      FirebaseFirestore.instance
          .collection('archivados')
          .doc(element.id)
          .delete();
    });
  }
}
