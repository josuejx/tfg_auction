import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_auction/models/producto.dart';
import 'package:tfg_auction/models/usuario.dart';

class PaymentScreen extends StatefulWidget {
  Producto producto;
  Usuario usuario;
  PaymentScreen({Key? key, required this.producto, required this.usuario})
      : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool payed = false;

  @override
  void initState() {
    super.initState();
    // simulate payment process 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        payed = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: payed
            ? SlideInLeft(
                child: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    Get.back();
                  },
                ),
              )
            : const SizedBox(),
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return payed
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElasticIn(
                    child: const Text("Pago realizado",
                        style: TextStyle(fontSize: 30))),
                ElasticIn(
                    child: const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green,
                  size: 80,
                )),
              ],
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
