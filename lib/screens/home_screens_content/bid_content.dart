import 'package:flutter/material.dart';
import 'package:tfg_auction/db/db_puja.dart';
import 'package:tfg_auction/models/puja.dart';
import 'package:tfg_auction/models/usuario.dart';
import 'package:tfg_auction/session.dart';
import 'package:tfg_auction/widgets/bid_card.dart';

class BidContent extends StatefulWidget {
  const BidContent({Key? key}) : super(key: key);

  @override
  State<BidContent> createState() => _BidContentState();
}

class _BidContentState extends State<BidContent> {
  Usuario? usuario;
  List<Puja> pujas = [];

  @override
  void initState() {
    cargarDatos();
    super.initState();
  }

  void cargarDatos() async {
    // Obtener usuario
    usuario = await Session().getSession();
    if (usuario != null) {
      // Obtener subastas
      pujas = await DBPuja().readAllByUser(usuario!.id!);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (usuario == null) {
      return const Center(
        child: Text("Debes iniciar sesión para ver tus pujas"),
      );
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
