import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_auction/db/db_producto.dart';
import 'package:tfg_auction/db/db_puja.dart';
import 'package:tfg_auction/db/db_usuario.dart';
import 'package:tfg_auction/models/producto.dart';
import 'package:tfg_auction/models/usuario.dart';
import 'package:tfg_auction/screens/product_screen.dart';

class MyProductsScreen extends StatefulWidget {
  Usuario usuario;

  MyProductsScreen({Key? key, required this.usuario}) : super(key: key);

  @override
  State<MyProductsScreen> createState() => _MyProductsScreenState();
}

class _MyProductsScreenState extends State<MyProductsScreen> {
  List<Producto> productos = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  void cargarDatos() async {
    productos = await DBProducto().readByUser(widget.usuario);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mis productos'),
          centerTitle: true,
        ),
        body: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: productos.length,
                itemBuilder: (context, index) {
                  DBProducto().isPagado(productos[index]).then((value) {
                    return _buildSubasta(context, productos[index], value);
                  });
                },
              ));
  }

  Widget _buildSubasta(BuildContext context, Producto producto, bool pagado) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                  child: InkWell(
                onTap: () {
                  Get.to(() => ProductScreen(producto: producto),
                      transition: Transition.zoom);
                },
                child: Hero(
                  tag: 'P${producto.id.toString()}',
                  child: FutureBuilder(
                    future: DBProducto().getImagen(producto),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        // rounded image
                        return Container(
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(snapshot.data!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              )),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  producto.nombre!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          const Divider(),
          Row(children: [
            Expanded(
              child: Text(
                'Precio: ${producto.precio.toString()}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (producto.finalizacion!.isAfter(DateTime.now()))
              Expanded(
                child: Text(
                  'Termina el ${producto.finalizacion!.day}/${producto.finalizacion!.month}/${producto.finalizacion!.year}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            else
              const Expanded(
                child: Text(
                  'Finalizada',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ]),
          const Divider(),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () async {
                    await DBProducto().delete(producto);
                    cargarDatos();
                  },
                  child: const Text(
                    'Eliminar',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ),
              ),
              if (!pagado)
                Expanded(
                  child: ElevatedButton(
                      onPressed: () async {
                        await DBPuja().deleteGanador(producto.id!);
                        Get.back();
                        Get.snackbar('Eliminado',
                            'El ganador de la puja ha sido eliminado, se esperará a que el siguiente usuario pague');
                      },
                      child: const Text('El usuario no ha pagado')),
                ),
            ],
          )
        ],
      ),
    );
  }
}
