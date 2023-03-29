import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfg_auction/db/db_usuario.dart';
import 'package:tfg_auction/models/usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    String token = await userCredential.user!.getIdToken();

    DBUsuario dbUsuario = DBUsuario();
    Usuario usuario = await dbUsuario.read(userCredential.user!.email!);
    usuario.token = token;
    dbUsuario.save(usuario, File(''));
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> updateEmail({required String email}) async {
    await _firebaseAuth.currentUser!.updateEmail(email);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
