import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_auction/db/db_categoria.dart';
import 'package:tfg_auction/models/categoria.dart';
import 'package:tfg_auction/screens/products_grid_screen.dart';
import 'package:tfg_auction/widgets/products_grid.dart';

class CategoryCard extends StatelessWidget {
  Categoria categoria;
  DBCategoria dbCategoria = DBCategoria();

  CategoryCard({Key? key, required this.categoria}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
            () => ProductsGridScreen(
                  titulo: categoria.nombre!,
                  filtrarPor: FiltrarPor.Categoria,
                  filtro: categoria.id.toString(),
                ),
            transition: Transition.cupertino);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: FutureBuilder(
                    future: dbCategoria.getImagen(categoria),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        return Image.network(
                          snapshot.data!,
                          fit: BoxFit.cover,
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                categoria.nombre!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
