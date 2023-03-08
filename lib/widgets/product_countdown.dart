import 'package:flutter/material.dart';

class ProductCountDown extends StatefulWidget {
  DateTime finalizacion;

  ProductCountDown({Key? key, required this.finalizacion}) : super(key: key);

  @override
  State<ProductCountDown> createState() => _ProductCountDownState();
}

class _ProductCountDownState extends State<ProductCountDown> {
  late DateTime _finalizacion;
  late Duration _diferencia;

  @override
  void initState() {
    _finalizacion = widget.finalizacion;
    _updateCountdown();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ProductCountDown oldWidget) {
    _finalizacion = widget.finalizacion;
    _updateCountdown();
    super.didUpdateWidget(oldWidget);
  }

  // update the countdown every second
  void _updateCountdown() {
    setState(() {
      _diferencia = _finalizacion.difference(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    // update the countdown every second
    Future.delayed(const Duration(seconds: 1), () {
      _updateCountdown();
    });
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '${_diferencia.inDays}d ${_diferencia.inHours % 24}h ${_diferencia.inMinutes % 60}m ${_diferencia.inSeconds % 60}s',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
