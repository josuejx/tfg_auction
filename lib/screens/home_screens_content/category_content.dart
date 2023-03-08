import 'package:flutter/material.dart';
import 'package:tfg_auction/models/categoria.dart';
import 'package:tfg_auction/widgets/category_card.dart';

class CategoryContent extends StatelessWidget {
  const CategoryContent({Key? key}) : super(key: key);

  List<Categoria> _generateCategoriaList() {
    List<Categoria> list = [];
    for (int i = 0; i < 10; i++) {
      list.add(Categoria(
        id: i,
        nombre: 'Categoria $i',
        imagen: 'https://picsum.photos/300/300',
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: MediaQuery.of(context).size.width / 300 > 2
          ? (MediaQuery.of(context).size.width ~/ 300 > 5
              ? 5
              : MediaQuery.of(context).size.width ~/ 300)
          : 2,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      padding: const EdgeInsets.all(40),
      shrinkWrap: true,
      children: [
        ..._generateCategoriaList().map(
          (categoria) => CategoryCard(
            categoria: categoria,
          ),
        ),
      ],
    );
  }
}
