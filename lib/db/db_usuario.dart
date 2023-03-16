import 'dart:convert';
import 'dart:io';
import 'package:tfg_auction/db/db_general.dart';
import 'package:tfg_auction/db/env.dart';
import 'package:tfg_auction/models/usuario.dart';
import 'package:http/http.dart' as http;

class DBUsuario {
  Future<List<Usuario>> readAll() async {
    try {
      final response = await http.get(Uri.parse("${Env.base_url}/usuario"));

      if (response.statusCode == 200 || response.statusCode == 201) {
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
      final response =
          await http.get(Uri.parse("${Env.base_url}/usuario/id/$id"));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Usuario.fromJson(json.decode(response.body)[0]);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Usuario?> readByEmail(String email) async {
    try {
      final response =
          await http.get(Uri.parse("${Env.base_url}/usuario/email/$email"));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final usuario = Usuario.fromJson(json.decode(response.body)[0]);
        return usuario;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String> create(Usuario usuario, File image) async {
    try {
      HttpClient httpClient = HttpClient();
      HttpClientRequest request =
          await httpClient.postUrl(Uri.parse("${Env.base_url}/usuario"));

      request.headers.set('Accept', 'application/json');
      request.headers.set('Content-type', 'application/json');
      request.add(utf8.encode(json.encode(usuario.toJson())));

      HttpClientResponse response = await request.close();

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (image.path != "") {
          usuario = (await readByEmail(usuario.email!))!;
          await DBGeneral.uploadImage(image, 'U${usuario.id.toString()}');
        }
        return "";
      } else if (response.statusCode == 400) {
        return "Compruebe que el email que está intentando registrar no está ya en uso";
      } else {
        return "Error de conexión con el servidor";
      }
    } catch (e) {
      print(e);
      return "Error de conexión con el servidor";
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

  String getImage(int idUsuario) {
    return "${Env.base_url}/image/U${idUsuario.toString()}";
  }
}
