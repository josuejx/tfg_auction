import 'package:flutter/material.dart';
import 'package:tfg_auction/db/db_categoria.dart';
import 'package:tfg_auction/models/categoria.dart';
import 'package:tfg_auction/widgets/products_grid.dart';

class HomeContent extends StatefulWidget {
  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  List<Categoria> categorias = [];

  void cargarCategorias() async {
    categorias = await DBCategoria().readAll();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Expanded(child: ProductsGrid())],
    );
  }

  Widget _buildCategoryHorizontalList() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: categorias
          .map((categoria) => Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                    ),
                    Text(categoria.nombre!)
                  ],
                ),
              ))
          .toList(),
    );
  }
}
