import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tfg_auction/db/db_categoria.dart';
import 'package:tfg_auction/db/db_producto.dart';
import 'package:tfg_auction/models/categoria.dart';
import 'package:tfg_auction/models/producto.dart';

class NewProductScreen extends StatefulWidget {
  const NewProductScreen({Key? key}) : super(key: key);

  @override
  State<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  List<Categoria> categorias = [];
  Producto producto = Producto();
  File image = File('');

  // Text controllers
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();

  @override
  void initState() {
    cargarDatos();
    super.initState();
  }

  void cargarDatos() async {
    categorias = await DBCategoria().readAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Crear producto'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: ListView(
                  children: _buildFormProduct(),
                ),
              ),
            ),
            const Divider(),
            // Boton de crear producto
            ElevatedButton(
              onPressed: () async {
                if (image.path == '') {
                  Get.snackbar('Error', 'Debes seleccionar una imagen',
                      colorText: Colors.white, backgroundColor: Colors.red);
                } else if (producto.nombre == null ||
                    producto.descripcion == null ||
                    producto.precio == null ||
                    producto.finalizacion == null ||
                    producto.idCategoria == null) {
                  Get.snackbar('Error', 'Debes rellenar todos los campos',
                      colorText: Colors.white, backgroundColor: Colors.red);
                } else {
                  producto.idUsuario = 1;
                  String result = await DBProducto().create(producto, image);
                  if (result == '') {
                    Get.snackbar(
                        'Producto creado', 'Producto creado correctamente',
                        colorText: Colors.white, backgroundColor: Colors.green);
                  } else {
                    Get.snackbar('Error', 'Ha ocurrido un error',
                        colorText: Colors.white, backgroundColor: Colors.red);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                fixedSize: Size(
                    MediaQuery.of(context).size.width / 3 > 150
                        ? MediaQuery.of(context).size.width / 3
                        : 150,
                    50.0),
              ),
              child: const Text('Crear producto'),
            ),
          ],
        ));
  }

  List<Widget> _buildFormProduct() {
    return [
      // Imagen
      InkWell(
        onTap: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['jpg', 'png', 'jpeg'],
          );
          if (result != null) {
            setState(() {
              image = File(result.files.single.path!);
            });
          }
        },
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          child: image.path == ''
              ? const Center(
                  child: Icon(Icons.image, size: 100.0),
                )
              : Image.file(image),
        ),
      ),
      const SizedBox(height: 20.0),
      // Dropdown de categorias
      DropdownButtonFormField(
        hint: const Text('Categoria'),
        items: categorias.map((Categoria categoria) {
          return DropdownMenuItem(
            value: categoria.id!,
            child: Text(categoria.nombre!),
          );
        }).toList(),
        onChanged: (dynamic value) {
          setState(() {
            producto.idCategoria = value;
          });
        },
      ),
      const SizedBox(height: 20.0),
      // Nombre
      TextFormField(
        controller: _nombreController,
        decoration: const InputDecoration(
          labelText: 'Nombre',
        ),
        onChanged: (String value) {
          setState(() {
            producto.nombre = value;
          });
        },
      ),
      const SizedBox(height: 20.0),
      // Descripcion
      TextFormField(
        controller: _descripcionController,
        decoration: const InputDecoration(
          labelText: 'Descripcion',
        ),
        onChanged: (String value) {
          setState(() {
            producto.descripcion = value;
          });
        },
      ),
      const SizedBox(height: 20.0),
      // Precio
      TextFormField(
        controller: _precioController,
        decoration: const InputDecoration(
          labelText: 'Precio',
          suffixIcon: Icon(Icons.euro),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
        ],
        onChanged: (String value) {
          if (double.tryParse(value) != null) {
            setState(() {
              producto.precio = double.parse(value);
            });
          }
        },
      ),
      const SizedBox(height: 20.0),
      DateTimePicker(
        initialValue: '',
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        dateLabelText: 'Date',
        onChanged: (val) {
          setState(() {
            producto.finalizacion = DateTime.parse(val);
          });
        },
      )
    ];
  }
}
