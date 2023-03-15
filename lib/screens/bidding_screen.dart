import 'package:flutter/material.dart';
import 'package:tfg_auction/models/producto.dart';

class BiddingScreen extends StatelessWidget {
  Producto producto;
  BiddingScreen({Key? key, required this.producto}) : super(key: key);

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
                        style: TextStyle(
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
                  onPressed: () {},
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
