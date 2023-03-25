import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfg_auction/models/usuario.dart';

class Session {
  Future<bool> login(String email, String password) async {
    final docUser = FirebaseFirestore.instance
        .collection('usuarios')
        .where('email', isEqualTo: email)
        .where('passwd', isEqualTo: password)
        .get();

    final doc = await docUser;

    if (doc.docs.isNotEmpty) {
      final usuario = Usuario.fromJson(doc.docs.first.data());
      setSession(usuario);
      return true;
    } else {
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

  Future logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('usuario');
  }
}
