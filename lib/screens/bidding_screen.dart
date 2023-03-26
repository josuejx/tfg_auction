import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_auction/auth.dart';
import 'package:tfg_auction/db/db_puja.dart';
import 'package:tfg_auction/db/db_usuario.dart';
import 'package:tfg_auction/models/producto.dart';
import 'package:tfg_auction/models/puja.dart';

class BiddingScreen extends StatelessWidget {
  Producto producto;
  BiddingScreen({Key? key, required this.producto}) : super(key: key);

  TextEditingController _cantidadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(producto.nombre!),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  children: [
                    // Puja actual
                    const Text(
                      'Puja actual',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${producto.precio.toString()} €',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    // Campo para introducir la cantidad de la puja
                    const SizedBox(height: 10),
                    const Text(
                      'Cantidad',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Cantidad',
                      ),
                      keyboardType: TextInputType.number,
                      controller: _cantidadController,
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async {
                    double cantidad = double.parse(_cantidadController.text);
                    if (cantidad > producto.precio!) {
                      producto.precio = cantidad;
                      var usuario = await DBUsuario()
                          .read((Auth().currentUser as User).email!);
                      Puja puja = Puja(
                        idProducto: producto.id,
                        idUsuario: usuario.email,
                        fecha: DateTime.now(),
                        cantidad: cantidad,
                      );
                      await DBPuja().save(puja);
                      Get.back();
                      Get.snackbar(
                          'Puja realizada', 'Has hecho una puja de $cantidad €',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white);
                    } else {
                      Get.snackbar('Error',
                          'La cantidad debe ser mayor que la puja actual',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    fixedSize: const Size(200, 50),
                  ),
                  child: const Text('Realizar puja'),
                ),
              ),
            ),
          ],
        ));
  }
}
