import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_auction/db/db_producto.dart';
import 'package:tfg_auction/models/producto.dart';
import 'package:tfg_auction/screens/product_screen.dart';
import 'package:tfg_auction/widgets/boton_archivar.dart';

class ProductCard extends StatelessWidget {
  Producto producto;
  DBProducto dbProducto = DBProducto();

  ProductCard({Key? key, required this.producto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.to(() => ProductScreen(producto: producto),
              transition: Transition.topLevel);
        },
        child: Stack(
          children: [
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Imagen
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Hero(
                      tag: 'P${producto.id.toString()}',
                      child: Image.network(
                        DBProducto().getImagen(producto.id!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Informacion
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nombre
                      Text(
                        producto.nombre!,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 300 > 2
                              ? 13
                              : 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (!GetPlatform.isAndroid && !GetPlatform.isIOS)
                        const SizedBox(height: 5),
                      if (!GetPlatform.isAndroid && !GetPlatform.isIOS)
                        Text(
                          producto.descripcion!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      const SizedBox(height: 5),
                      Text(
                        '${producto.precio!.toStringAsFixed(2)} €',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 300 > 2
                              ? 12
                              : 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Estado
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          getStatus(),
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width / 300 > 2
                                    ? 12
                                    : 14,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: BotonArchivar(),
            ),
          ],
        ));
  }

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
}
