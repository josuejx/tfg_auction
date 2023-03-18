import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tfg_auction/db/env.dart';
import 'package:tfg_auction/models/archivado.dart';

class DBArchivado {
  Future<List<Archivado>> readAll() async {
    try {
      final response = await http.get(Uri.parse("${Env.base_url}/archivado"));

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Archivado> archivados = [];
        for (var item in json.decode(response.body)) {
          archivados.add(Archivado.fromJson(item));
        }
        return archivados;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Archivado>> readByUser(int idUsuario) async {
    try {
      final response = await http
          .get(Uri.parse("${Env.base_url}/archivado/idUsuario/$idUsuario"));

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Archivado> archivados = [];
        for (var item in json.decode(response.body)) {
          archivados.add(Archivado.fromJson(item));
        }
        return archivados;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<Archivado> read(int id) async {
    try {
      final response =
          await http.get(Uri.parse("${Env.base_url}/archivado/$id"));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Archivado.fromJson(json.decode(response.body));
      } else {
        return Archivado();
      }
    } catch (e) {
      print(e);
      return Archivado();
    }
  }

  Future<Archivado> readByUserAndProduct(int idUsuario, int idProducto) async {
    try {
      List<Archivado> archivados = await readByUser(idUsuario);
      for (var item in archivados) {
        if (item.idProducto == idProducto) {
          return item;
        }
      }
      return Archivado();
    } catch (e) {
      print(e);
      return Archivado();
    }
  }

  Future<String> create(Archivado archivado) async {
    try {
      HttpClient httpClient = HttpClient();
      HttpClientRequest request =
          await httpClient.postUrl(Uri.parse("${Env.base_url}/archivado"));

      request.headers.set('Accept', 'application/json');
      request.headers.set('Content-type', 'application/json');
      request.add(utf8.encode(json.encode(archivado.toJson())));

      HttpClientResponse response = await request.close();

      if (response.statusCode == 200 || response.statusCode == 201) {
        return "";
      } else {
        return "Fallo al archivar el producto";
      }
    } catch (e) {
      print(e);
      return "Error de conexión con el servidor";
    }
  }

  Future<String> delete(int id) async {
    try {
      HttpClient httpClient = HttpClient();
      HttpClientRequest request = await httpClient
          .deleteUrl(Uri.parse("${Env.base_url}/archivado/$id"));

      HttpClientResponse response = await request.close();

      if (response.statusCode == 200 || response.statusCode == 201) {
        return "";
      } else {
        return "Fallo al desarchivar el producto";
      }
    } catch (e) {
      print(e);
      return "Error de conexión con el servidor";
    }
  }
}
