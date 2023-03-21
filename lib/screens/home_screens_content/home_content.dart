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
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    cargarCategorias();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCategoryHorizontalList(),
        Expanded(child: SingleChildScrollView(child: ProductsGrid())),
      ],
    );
  }

  Widget _buildCategoryHorizontalList() {
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: categorias
            .map((categoria) => Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: Image.network(
                                DBCategoria().getImagen(categoria.imagen!))
                            .image,
                      ),
                      Text(categoria.nombre!)
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
