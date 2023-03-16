import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_auction/db/db_categoria.dart';
import 'package:tfg_auction/models/categoria.dart';
import 'package:tfg_auction/widgets/category_card.dart';

class CategoryContent extends StatefulWidget {
  const CategoryContent({Key? key}) : super(key: key);

  @override
  State<CategoryContent> createState() => _CategoryContentState();
}

class _CategoryContentState extends State<CategoryContent> {
  List<Categoria> categorias = [];

  @override
  void initState() {
    cargarDatos();
    super.initState();
  }

  void cargarDatos() async {
    final listaCategorias = await DBCategoria().readAll();
    setState(() {
      categorias = listaCategorias;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GridView.count(
        crossAxisCount: MediaQuery.of(context).size.width / 300 > 2
            ? (MediaQuery.of(context).size.width ~/ 300 > 5
                ? 5
                : MediaQuery.of(context).size.width ~/ 300)
            : 2,
        crossAxisSpacing: GetPlatform.isAndroid || GetPlatform.isIOS ? 5 : 20,
        mainAxisSpacing: GetPlatform.isAndroid || GetPlatform.isIOS ? 5 : 20,
        padding: EdgeInsets.all(
            GetPlatform.isAndroid || GetPlatform.isIOS ? 10 : 40),
        shrinkWrap: true,
        children: [
          ...categorias.map(
            (categoria) => CategoryCard(
              categoria: categoria,
            ),
          ),
        ],
      ),
    );
  }
}
