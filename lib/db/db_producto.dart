import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tfg_auction/db/db_general.dart';
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

  Future<List<Producto>> readByUser(int idUsuario) async {
    try {
      final response = await http
          .get(Uri.parse("${Env.base_url}/producto/idUsuario/$idUsuario"));

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

  Future<Producto> readByUserAndName(
      int idUsuario, String nombreProducto) async {
    try {
      List<Producto> productos = await readByUser(idUsuario);
      for (var producto in productos) {
        if (producto.nombre == nombreProducto) {
          return producto;
        }
      }
      return Producto();
    } catch (e) {
      print(e);
      return Producto();
    }
  }

  Future<String> create(Producto producto, File image) async {
    try {
      HttpClient httpClient = HttpClient();
      HttpClientRequest request =
          await httpClient.postUrl(Uri.parse("${Env.base_url}/producto"));

      request.headers.set('Accept', 'application/json');
      request.headers.set('Content-type', 'application/json');
      request.add(utf8.encode(json.encode(producto.toJson())));

      HttpClientResponse response = await request.close();

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (image.path != "") {
          producto =
              (await readByUserAndName(producto.idUsuario!, producto.nombre!));
          await DBGeneral.uploadImage(image, 'P${producto.id.toString()}');
        }
        return "";
      } else {
        return "Fallo al crear el producto";
      }
    } catch (e) {
      print(e);
      return "Error de conexión con el servidor";
    }
  }

  String getImagen(int idProducto) {
    return "${Env.base_url}/image/P${idProducto.toString()}";
  }
}
