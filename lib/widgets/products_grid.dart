import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_auction/db/db_producto.dart';
import 'package:tfg_auction/models/producto.dart';
import 'package:tfg_auction/widgets/product_card.dart';

class ProductsGrid extends StatefulWidget {
  FiltrarPor? filtrarPor;
  String? filtro;

  ProductsGrid({Key? key, this.filtrarPor, this.filtro}) : super(key: key);

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  List<Producto> _productos = [];
  bool cargando = true;

  @override
  void initState() {
    cargarDatos();
    super.initState();
  }

  void cargarDatos() async {
    final listaProductos = await DBProducto().readAll();
    if (widget.filtrarPor == FiltrarPor.Categoria) {
      listaProductos.removeWhere(
          (element) => element.idCategoria != int.parse(widget.filtro!));
    } else if (widget.filtrarPor == FiltrarPor.Nombre) {
      listaProductos.removeWhere((element) => !element.nombre!
          .toLowerCase()
          .contains(widget.filtro!.toLowerCase()));
    }
    setState(() {
      _productos = listaProductos;
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

    return _productos.isEmpty
        ? const Center(
            child: Text('No hay productos'),
          )
        : SingleChildScrollView(
            child: GridView.count(
              crossAxisCount: MediaQuery.of(context).size.width / 300 > 2
                  ? (MediaQuery.of(context).size.width ~/ 300 > 5
                      ? 5
                      : MediaQuery.of(context).size.width ~/ 300)
                  : 2,
              crossAxisSpacing:
                  GetPlatform.isAndroid || GetPlatform.isIOS ? 5 : 20,
              mainAxisSpacing:
                  GetPlatform.isAndroid || GetPlatform.isIOS ? 5 : 20,
              padding: EdgeInsets.all(
                  GetPlatform.isAndroid || GetPlatform.isIOS ? 10 : 40),
              shrinkWrap: true,
              children: [
                ..._productos.map((e) => ProductCard(producto: e)).toList(),
              ],
            ),
          );
  }
}

enum FiltrarPor { Categoria, Nombre }
