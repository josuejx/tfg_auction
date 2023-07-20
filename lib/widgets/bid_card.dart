import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_auction/db/db_producto.dart';
import 'package:tfg_auction/db/db_puja.dart';
import 'package:tfg_auction/db/db_usuario.dart';
import 'package:tfg_auction/models/producto.dart';
import 'package:tfg_auction/models/puja.dart';
import 'package:tfg_auction/models/usuario.dart';
import 'package:tfg_auction/screens/payment_screen.dart';
import 'package:tfg_auction/screens/product_screen.dart';

class BidCard extends StatefulWidget {
  Puja puja;
  Usuario usuario;

  BidCard({Key? key, required this.puja, required this.usuario})
      : super(key: key);

  @override
  State<BidCard> createState() => _BidCardState();
}

class _BidCardState extends State<BidCard> {
  Producto producto = Producto();
  List<Puja> pujas = [];
  List<Usuario> usuarios = [];

  bool expanded = false;
  bool pagado = false;

  @override
  void initState() {
    cargarDatos();
    super.initState();
  }

  void cargarDatos() async {
    DBProducto dbProducto = DBProducto();
    producto = await dbProducto.read(widget.puja.idProducto!);
    pagado = await dbProducto.isPagado(producto);
    DBPuja dbPuja = DBPuja();
    pujas = await dbPuja.readAllByProduct(widget.puja.idProducto!);
    pujas.sort((a, b) => b.cantidad!.compareTo(a.cantidad!));
    DBUsuario dbUsuario = DBUsuario();
    for (var puja in pujas) {
      Usuario? usuario = await dbUsuario.read(puja.idUsuario!);
      usuarios.add(usuario);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: producto.id == null
            ? const ListTile(
                title: Text("Cargando..."),
              )
            : Column(
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
                      Expanded(
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () {
                                Get.to(() => ProductScreen(producto: producto),
                                    transition: Transition.zoom);
                              },
                              title: Text(producto.nombre!),
                              subtitle: Text("Inicial: ${producto.precio}€"),
                            ),
                            if (producto.finalizacion!.isAfter(DateTime.now()))
                              Card(
                                color: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Finaliza en: ${producto.finalizacion!.difference(DateTime.now()).inDays} días",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            if (producto.finalizacion!.isBefore(DateTime.now()))
                              const Card(
                                color: Colors.red,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Finalizado",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (producto.finalizacion!.isBefore(DateTime.now()) &&
                      usuarios.first.email == widget.usuario.email &&
                      !pagado) ...[
                    const Divider(),
                    const Text(
                      "¡Enhorabuena! Has ganado la puja",
                      style: TextStyle(color: Colors.green, fontSize: 20),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Get.to(() => PaymentScreen(
                              producto: producto, usuario: widget.usuario));
                        },
                        child: const Text("Pasar por caja")),
                    const Divider()
                  ],
                  if (producto.finalizacion!.isBefore(DateTime.now()) &&
                      usuarios.first.email == widget.usuario.email &&
                      pagado) ...[
                    const Divider(),
                    const Text(
                      "Puja pagada",
                      style: TextStyle(color: Colors.green, fontSize: 20),
                    ),
                    const Icon(Icons.check_circle,
                        color: Colors.green, size: 50),
                    const Divider()
                  ],
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            expanded = !expanded;
                          });
                        },
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        icon: expanded
                            ? const Icon(Icons.expand_less)
                            : const Icon(Icons.expand_more),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text("Pujas: ${pujas.length}"),
                          subtitle:
                              Text("Última puja: ${pujas.first.cantidad}€"),
                        ),
                      ),
                      if (usuarios.first.email != null &&
                          producto.finalizacion!.isBefore(DateTime.now()))
                        Expanded(
                          child: ListTile(
                            title: const Text("Ganador de la puja:"),
                            subtitle: Text(usuarios.first.nombreUsuario!),
                          ),
                        ),
                    ],
                  ),
                  if (expanded) const Divider(),
                  if (expanded)
                    Wrap(
                      children: [
                        for (int i = 0; i < pujas.length; i++)
                          ListTile(
                            title: usuarios[i].email != widget.usuario.email
                                ? Text(usuarios[i].nombreUsuario.toString())
                                : Text(usuarios[i].nombreUsuario.toString(),
                                    style: const TextStyle(color: Colors.blue)),
                            subtitle: Text(pujas[i].fecha.toString().substring(
                                0, pujas[i].fecha.toString().length - 7)),
                            trailing: Text('${pujas[i].cantidad.toString()}€'),
                          ),
                      ],
                    )
                ],
              ));
  }
}
