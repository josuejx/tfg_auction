import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tfg_auction/db/env.dart';
import 'package:tfg_auction/models/categoria.dart';

class DBCategoria {
  Future<List<Categoria>> readAll() async {
    try {
      final response = await http.get(Uri.parse("${Env.base_url}/categoria"));

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Categoria> categorias = [];
        for (var item in json.decode(response.body)) {
          categorias.add(Categoria.fromJson(item));
        }
        return categorias;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  String getImagen(String imagen) {
    imagen = imagen.replaceAll(RegExp(r'\.[a-zA-Z0-9]+$'), '');
    return "${Env.base_url}/image/C$imagen";
  }
}
