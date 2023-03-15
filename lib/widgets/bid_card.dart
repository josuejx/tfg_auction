import 'package:flutter/material.dart';
import 'package:tfg_auction/db/db_producto.dart';
import 'package:tfg_auction/models/producto.dart';
import 'package:tfg_auction/models/puja.dart';
import 'package:tfg_auction/models/usuario.dart';

class BidCard extends StatefulWidget {
  Puja puja;
  Usuario usuario;

  BidCard({Key? key, required this.puja, required this.usuario})
      : super(key: key);

  @override
  State<BidCard> createState() => _BidCardState();
}

class _BidCardState extends State<BidCard> {
  Producto producto = Producto();

  @override
  void initState() {
    cargarDatos();
    super.initState();
  }

  void cargarDatos() async {
    DBProducto dbProducto = DBProducto();
    // Obtener producto
    producto = await dbProducto.read(widget.puja.idProducto!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: producto.id == null
          ? const ListTile(
              title: Text("Cargando..."),
              trailing: CircularProgressIndicator(),
            )
          : ListTile(
              leading: Image.network(
                DBProducto().getImagen(producto.id!),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              title: Text(producto.nombre!),
              subtitle: Text("Puja: ${widget.puja.cantidad}"),
            ),
    );
  }
}
