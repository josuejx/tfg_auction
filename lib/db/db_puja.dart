import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tfg_auction/models/producto.dart';
import 'package:tfg_auction/models/puja.dart';
import 'package:tfg_auction/models/usuario.dart';

class DBPuja {
  Future<List<Puja>> readAll() async {
    final docPuja = FirebaseFirestore.instance.collection('pujas').get();

    final doc = await docPuja;

    final pujas = <Puja>[];

    doc.docs.forEach((element) {
      pujas.add(Puja.fromJson(element.data()));
    });

    return pujas;
  }

  Future<List<Puja>> readAllByUser(Usuario usuario) async {
    final docPuja = FirebaseFirestore.instance
        .collection('pujas')
        .where('idUsuario', isEqualTo: usuario.email)
        .get();

    final doc = await docPuja;

    final pujas = <Puja>[];

    doc.docs.forEach((element) {
      pujas.add(Puja.fromJson(element.data()));
    });

    return pujas;
  }

  Future<List<Puja>> readAllByProduct(int idProducto) async {
    final docPuja = FirebaseFirestore.instance
        .collection('pujas')
        .where('idProducto', isEqualTo: idProducto)
        .get();

    final doc = await docPuja;

    final pujas = <Puja>[];

    doc.docs.forEach((element) {
      pujas.add(Puja.fromJson(element.data()));
    });

    return pujas;
  }

  Future<void> save(Puja puja) async {
    final docPuja = FirebaseFirestore.instance
        .collection('pujas')
        .where('idUsuario', isEqualTo: puja.idUsuario)
        .where('idProducto', isEqualTo: puja.idProducto)
        .where('fecha', isEqualTo: puja.fecha)
        .get();

    final doc = await docPuja;

    if (doc.docs.isEmpty) {
      await FirebaseFirestore.instance.collection('pujas').add(puja.toJson());
    }
  }

  Future<void> deleteByProducto(int idProducto) async {
    final docPuja = FirebaseFirestore.instance
        .collection('pujas')
        .where('idProducto', isEqualTo: idProducto)
        .get();

    final doc = await docPuja;

    if (doc.docs.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('pujas')
          .doc(doc.docs.first.id)
          .delete();
    }
  }

  Future<void> deleteGanador(int idProducto) async {
    var pujas = await readAllByProduct(idProducto);
    String idUsuario = pujas
        .reduce((value, element) =>
            value.cantidad! > element.cantidad! ? value : element)
        .idUsuario!;

    final docPuja = FirebaseFirestore.instance
        .collection('pujas')
        .where('idProducto', isEqualTo: idProducto)
        .where('idUsuario', isEqualTo: idUsuario)
        .get();

    final doc = await docPuja;

    if (doc.docs.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('pujas')
          .doc(doc.docs.first.id)
          .delete();
    }
  }
}
