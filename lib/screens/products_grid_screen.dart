import 'package:flutter/material.dart';
import 'package:tfg_auction/widgets/products_grid.dart';

class ProductsGridScreen extends StatelessWidget {
  FiltrarPor? filtrarPor;
  String? filtro;
  String? titulo;

  ProductsGridScreen(
      {Key? key, required this.titulo, this.filtrarPor, this.filtro})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo!),
        centerTitle: true,
      ),
      body: ProductsGrid(
        filtrarPor: filtrarPor,
        filtro: filtro,
      ),
    );
  }
}
