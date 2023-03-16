import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_auction/db/db_producto.dart';
import 'package:tfg_auction/models/producto.dart';
import 'package:tfg_auction/screens/product_screen.dart';

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
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Imagen
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(DBProducto().getImagen(producto.id!)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Informacion
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nombre
                      Text(
                        producto.nombre!,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 300 > 2
                              ? 14
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
                              ? 14
                              : 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Estado
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          getStatus(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
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
