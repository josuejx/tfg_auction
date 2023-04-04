import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_auction/db/db_producto.dart';
import 'package:tfg_auction/db/db_puja.dart';
import 'package:tfg_auction/db/db_usuario.dart';
import 'package:tfg_auction/models/producto.dart';
import 'package:tfg_auction/models/puja.dart';
import 'package:tfg_auction/models/usuario.dart';
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

  @override
  void initState() {
    cargarDatos();
    super.initState();
  }

  void cargarDatos() async {
    DBProducto dbProducto = DBProducto();
    producto = await dbProducto.read(widget.puja.idProducto!);
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
                        child: ListTile(
                          onTap: () {
                            Get.to(() => ProductScreen(producto: producto),
                                transition: Transition.zoom);
                          },
                          title: Text(producto.nombre!),
                          subtitle: Text("Inicial: ${producto.precio}€"),
                        ),
                      ),
                    ],
                  ),
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
                            title: usuarios[i].email == widget.usuario.email
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
