import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tfg_auction/db/env.dart';
import 'package:tfg_auction/models/puja.dart';

class DBPuja {
  Future<List<Puja>> readAll() async {
    try {
      final response = await http.get(Uri.parse("${Env.base_url}/puja"));

      if (response.statusCode == 200) {
        List<Puja> pujas = [];
        for (var item in json.decode(response.body)) {
          pujas.add(Puja.fromJson(item));
        }
        return pujas;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Puja>> readAllByUser(int idUsuario) async {
    try {
      final response = await http
          .get(Uri.parse("${Env.base_url}/puja/idUsuario/$idUsuario"));

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Puja> pujas = [];
        for (var item in json.decode(response.body)) {
          pujas.add(Puja.fromJson(item));
        }
        return pujas;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Puja>> readAllByProduct(int idProducto) async {
    try {
      final response = await http
          .get(Uri.parse("${Env.base_url}/puja/idProducto/$idProducto"));

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Puja> pujas = [];
        for (var item in json.decode(response.body)) {
          pujas.add(Puja.fromJson(item));
        }
        return pujas;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
