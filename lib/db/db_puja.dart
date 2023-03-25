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
}
