import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfg_auction/db/db_usuario.dart';
import 'package:tfg_auction/firebase_options.dart';
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

  Future googleSignUp() async {
    DBUsuario dbUsuario = DBUsuario();
    Usuario usuario = Usuario();

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    String token = await userCredential.user!.getIdToken();

    usuario.token = token;
    usuario.email = userCredential.user!.email!;
    usuario.nombreUsuario = userCredential.user!.displayName!;
    usuario.nombreCompleto = userCredential.user!.displayName!;
    File imagen = File.fromUri(Uri.parse(userCredential.user!.photoURL!));
    dbUsuario.save(usuario, imagen);
  }

  Future googleSignIn() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
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
