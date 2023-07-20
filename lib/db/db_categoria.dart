import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tfg_auction/models/categoria.dart';

class DBCategoria {
  Future<List<Categoria>> readAll() async {
    final docCategoria =
        FirebaseFirestore.instance.collection('categorias').get();

    final doc = await docCategoria;

    final categorias = <Categoria>[];

    doc.docs.forEach((element) {
      categorias.add(Categoria.fromJson(element.data()));
    });

    return categorias;
  }

  Future<String> getImagen(Categoria categoria) async {
    final storageRef = FirebaseStorage.instance.ref('categorias');

    final url =
        await storageRef.child(categoria.imagen.toString()).getDownloadURL();

    return url;
  }
}
