import 'dart:convert';

import 'package:tfg_auction/db/env.dart';
import 'package:tfg_auction/models/usuario.dart';
import 'package:http/http.dart' as http;

class DBUsuario {
  Future<List<Usuario>> readAll() async {
    try {
      final response = await http.get(Uri.parse("${Env.base_url}/usuario"));

      if (response.statusCode == 200) {
        List<Usuario> usuarios = [];
        for (var item in json.decode(response.body)) {
          usuarios.add(Usuario.fromJson(item));
        }
        return usuarios;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<Usuario?> read(int id) async {
    try {
      final response = await http.get(Uri.parse("${Env.base_url}/usuario/$id"));

      if (response.statusCode == 200) {
        return Usuario.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Usuario?> create(Usuario usuario) async {
    try {
      final response = await http.post(
        Uri.parse("${Env.base_url}/usuario"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(usuario.toJson()),
      );

      if (response.statusCode == 200) {
        return Usuario.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Usuario?> update(Usuario usuario) async {
    try {
      final response = await http.put(
        Uri.parse("${Env.base_url}/usuario/${usuario.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(usuario.toJson()),
      );

      if (response.statusCode == 200) {
        return Usuario.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> delete(int id) async {
    try {
      final response =
          await http.delete(Uri.parse("${Env.base_url}/usuario/$id"));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
