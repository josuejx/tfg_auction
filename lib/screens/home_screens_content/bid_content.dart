import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tfg_auction/auth.dart';
import 'package:tfg_auction/db/db_puja.dart';
import 'package:tfg_auction/db/db_usuario.dart';
import 'package:tfg_auction/models/puja.dart';
import 'package:tfg_auction/models/usuario.dart';
import 'package:tfg_auction/screens/request_login_screen.dart';
import 'package:tfg_auction/widgets/bid_card.dart';

class BidContent extends StatefulWidget {
  const BidContent({Key? key}) : super(key: key);

  @override
  State<BidContent> createState() => _BidContentState();
}

class _BidContentState extends State<BidContent> {
  Usuario? usuario;
  List<Puja> pujas = [];
  bool cargando = true;

  @override
  void initState() {
    cargarDatos();
    super.initState();
  }

  void cargarDatos() async {
    if (Auth().currentUser != null) {
      usuario = await DBUsuario().read((Auth().currentUser as User).email!);
      pujas = await DBPuja().readAllByUser(usuario!);

      // quitar pujas que sean del mismo idProducto
      for (var i = 0; i < pujas.length; i++) {
        for (var j = i + 1; j < pujas.length; j++) {
          if (pujas[i].idProducto == pujas[j].idProducto) {
            pujas.removeAt(j);
            j--;
          }
        }
      }
    }
    setState(() {
      cargando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (cargando) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (usuario == null) {
      return RequestLoginScreen();
    } else if (pujas.isEmpty) {
      return const Center(
        child: Text("No tienes pujas"),
      );
    } else {
      return ListView.builder(
        itemCount: pujas.length,
        itemBuilder: (context, index) {
          return BidCard(
            puja: pujas[index],
            usuario: usuario!,
          );
        },
      );
    }
  }
}
