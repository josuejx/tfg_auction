import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tfg_auction/db/env.dart';
import 'package:tfg_auction/models/producto.dart';

class DBProducto {
  Future<List<Producto>> readAll() async {
    try {
      final response = await http.get(Uri.parse("${Env.base_url}/producto"));

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Producto> productos = [];
        for (var item in json.decode(response.body)) {
          productos.add(Producto.fromJson(item));
        }
        return productos;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<Producto> read(int idProducto) async {
    try {
      final response =
          await http.get(Uri.parse("${Env.base_url}/producto/id/$idProducto"));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Producto.fromJson(json.decode(response.body)[0]);
      } else {
        return Producto();
      }
    } catch (e) {
      print(e);
      return Producto();
    }
  }

  String getImagen(int idProducto) {
    return "${Env.base_url}/image/P${idProducto.toString()}";
  }
}
