import 'package:flutter/material.dart';
import 'package:tfg_auction/models/producto.dart';
import 'package:tfg_auction/widgets/layout/auction_appbar.dart';
import 'package:tfg_auction/widgets/layout/auction_drawer.dart';
import 'package:tfg_auction/widgets/layout/bottom_bar.dart';
import 'package:tfg_auction/widgets/product_card.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  List<Producto> _createProductoList() {
    List<Producto> productos = [];
    for (int i = 0; i < 10; i++) {
      productos.add(Producto(
        id: i,
        nombre: 'Producto $i',
        descripcion: 'Descripcion del producto $i',
        precio: 10.0,
        imagen: 'https://picsum.photos/200/300',
        finalizacion: DateTime.now().add(Duration(days: i)),
      ));
    }

    return productos;
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
        ..._createProductoList().map((e) => ProductCard(producto: e)).toList(),
      ],
    );
  }
}
