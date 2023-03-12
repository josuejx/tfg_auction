import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfg_auction/db/env.dart';
import 'package:tfg_auction/models/usuario.dart';

class Session {
  Future<bool> login(String email, String passwd) async {
    try {
      final response =
          await http.get(Uri.parse("${Env.base_url}/usuario/email/$email"));

      if (response.statusCode == 200) {
        final usuario = Usuario.fromJson(jsonDecode(response.body)[0]);
        if (usuario.password == passwd) {
          setSession(usuario);
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  void setSession(Usuario usuario) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('usuario', jsonEncode(usuario.toJson()));
    });
  }

  Future<Usuario?> getSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usuario = prefs.getString('usuario');
      if (usuario != null) {
        return Usuario.fromJson(jsonDecode(usuario));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  void logout() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('usuario');
    });
  }
}
