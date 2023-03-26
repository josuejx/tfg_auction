import 'package:cupertino_modal_sheet/cupertino_modal_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:tfg_auction/db/db_producto.dart';
import 'package:tfg_auction/db/db_usuario.dart';
import 'package:tfg_auction/models/producto.dart';
import 'package:tfg_auction/models/usuario.dart';
import 'package:tfg_auction/screens/bidding_screen.dart';

class ProductScreen extends StatefulWidget {
  Producto producto;

  ProductScreen({Key? key, required this.producto}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  DBProducto dbProducto = DBProducto();

  DBUsuario dbUsuario = DBUsuario();
  Usuario usuario = Usuario();

  @override
  void initState() {
    cargarDatos();
    super.initState();
  }

  void cargarDatos() async {
    final usuarioLeido = await dbUsuario.read(widget.producto.idUsuario!);
    setState(() {
      usuario = usuarioLeido;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.producto.nombre!),
        ),
        body: ListView(
          children: [
            InkWell(
              onTap: () async {
                String url = await dbProducto.getImagen(widget.producto);
                Get.dialog(Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon: const Icon(Icons.clear, color: Colors.white),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    backgroundColor: Colors.black,
                    elevation: 0,
                  ),
                  body: Center(
                    child: PhotoView(
                      imageProvider: NetworkImage(url),
                    ),
                  ),
                ));
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.width / 2 > 300
                    ? 300
                    : MediaQuery.of(context).size.width / 2,
                child: Hero(
                  tag: 'P${widget.producto.id.toString()}',
                  child: FutureBuilder(
                    future: dbProducto.getImagen(widget.producto),
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
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.producto.nombre!,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 40 < 16
                          ? 16
                          : (MediaQuery.of(context).size.width / 40 > 32
                              ? 32
                              : MediaQuery.of(context).size.width / 40),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${widget.producto.precio.toString()} €',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 45 < 14
                              ? 14
                              : (MediaQuery.of(context).size.width / 45 > 30
                                  ? 30
                                  : MediaQuery.of(context).size.width / 45),
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'Termina el ${widget.producto.finalizacion!.day}/${widget.producto.finalizacion!.month}/${widget.producto.finalizacion!.year}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width / 50 <
                                    14
                                ? 14
                                : (MediaQuery.of(context).size.width / 50 > 25
                                    ? 25
                                    : MediaQuery.of(context).size.width / 50),
                          ),
                        ),
                      )
                    ],
                  ),
                  const Divider(),
                  _buildUserInfo(),
                  const Divider(),
                  Text(
                    widget.producto.descripcion!,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 40 < 12
                          ? 12
                          : (MediaQuery.of(context).size.width / 40 > 25
                              ? 25
                              : MediaQuery.of(context).size.width / 40),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        onPressed: () {
                          showCupertinoModalSheet(
                            context: context,
                            builder: (context) =>
                                BiddingScreen(producto: widget.producto),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fixedSize: Size(
                            MediaQuery.of(context).size.width / 2,
                            50,
                          ),
                        ),
                        child: Text('Pujar',
                            style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width /
                                            50 <
                                        14
                                    ? 14
                                    : (MediaQuery.of(context).size.width / 50 >
                                            22
                                        ? 22
                                        : MediaQuery.of(context).size.width /
                                            50)))),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Widget _buildUserInfo() {
    if (usuario.email == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          FutureBuilder(
              future: dbUsuario.getImage(usuario),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == null) {
                    return CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: Image.asset(
                        'assets/user.png',
                        fit: BoxFit.cover,
                      ).image,
                    );
                  }
                  return CircleAvatar(
                    backgroundImage: Image.network(
                      snapshot.data!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/user.png',
                          fit: BoxFit.cover,
                        );
                      },
                    ).image,
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }),
          const SizedBox(
            width: 10,
          ),
          Text(
            usuario.nombreUsuario!,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 50 < 14
                  ? 14
                  : (MediaQuery.of(context).size.width / 50 > 22
                      ? 22
                      : MediaQuery.of(context).size.width / 50),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
