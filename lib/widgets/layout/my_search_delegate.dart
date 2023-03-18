import 'package:flutter/material.dart';
import 'package:tfg_auction/db/db_producto.dart';
import 'package:tfg_auction/screens/products_grid_screen.dart';
import 'package:tfg_auction/widgets/products_grid.dart';

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ProductsGridScreen(
      filtrarPor: FiltrarPor.Nombre,
      filtro: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: DBProducto().readByQuery(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<String> lista = snapshot.data as List<String>;
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(lista[index]),
                onTap: () {
                  query = lista[index];
                  showResults(context);
                },
              );
            },
            itemCount: lista.length,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
