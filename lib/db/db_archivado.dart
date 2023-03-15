import 'dart:convert';

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
}
