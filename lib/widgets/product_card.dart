import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:tfg_auction/db/db_producto.dart';
import 'package:tfg_auction/models/producto.dart';
import 'package:tfg_auction/screens/product_screen.dart';
import 'package:tfg_auction/widgets/boton_archivar.dart';

class ProductCard extends StatelessWidget {
  Producto producto;
  DBProducto dbProducto = DBProducto();
  final autoSizeGroup = AutoSizeGroup();

  ProductCard({Key? key, required this.producto}) : super(key: key);

  String getStatus() {
    int days = producto.finalizacion!.difference(DateTime.now()).inDays;
    if (days > 0) {
      return '${producto.finalizacion!.difference(DateTime.now()).inDays} días';
    } else if (days == 0) {
      return 'Termina hoy';
    } else {
      return 'Finalizado';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ProductScreen(producto: producto),
            transition: Transition.cupertino);
      },
      child: Stack(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Column(children: [
              Expanded(
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      child: Hero(
                        tag: 'P${producto.id!.toString()}',
                        child: Image.network(
                          dbProducto.getImagen(producto.id!),
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return const Center(
                              child: Text('Error al cargar la imagen'),
                            );
                          },
                        ),
                      ))),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText(
                            producto.nombre!,
                            style: const TextStyle(fontSize: 20),
                            maxLines: 1,
                            group: autoSizeGroup,
                          ),
                          AutoSizeText(
                            '${producto.precio!.toStringAsFixed(2)}€',
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                            group: autoSizeGroup,
                          ),
                        ],
                      ),
                      AutoSizeText(
                        producto.descripcion!,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.grey),
                        maxLines: 2,
                        group: autoSizeGroup,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: SlideCountdown(
                          duration:
                              producto.finalizacion!.difference(DateTime.now()),
                          slideDirection: SlideDirection.up,
                          separator: ':',
                          textStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          replacement: const Text(
                            'Finalizado',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
          Positioned(
              top: 10,
              right: 10,
              child: BotonArchivar(idProducto: producto.id!)),
        ],
      ),
    );
  }
}
