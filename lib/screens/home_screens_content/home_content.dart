import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_auction/db/db_categoria.dart';
import 'package:tfg_auction/models/categoria.dart';
import 'package:tfg_auction/screens/products_grid_screen.dart';
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
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: _buildCategoryHorizontalList()),
        const Divider(),
        Expanded(child: ProductsGrid()),
      ],
    );
  }

  Widget _buildCategoryHorizontalList() {
    return SizedBox(
      height: 100,
      width: Get.width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: categorias
            .map((categoria) => Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      InkWell(
                          onTap: () {
                            Get.to(
                                () => ProductsGridScreen(
                                      titulo: categoria.nombre!,
                                      filtrarPor: FiltrarPor.Categoria,
                                      filtro: categoria.id.toString(),
                                    ),
                                transition: Transition.cupertino);
                          },
                          child: FutureBuilder(
                            future: DBCategoria().getImagen(categoria),
                            builder: (context, AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData) {
                                return CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      Image.network(snapshot.data!).image,
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          )),
                      Text(categoria.nombre!)
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
