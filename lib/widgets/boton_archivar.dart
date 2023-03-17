import 'package:flutter/material.dart';

class BotonArchivar extends StatefulWidget {
  @override
  State<BotonArchivar> createState() => _BotonArchivarState();
}

class _BotonArchivarState extends State<BotonArchivar> {
  bool _archivado = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _archivado ? Icons.archive : Icons.archive_outlined,
        color: _archivado ? Colors.blue : Colors.black,
      ),
      onPressed: () {
        setState(() {
          _archivado = !_archivado;
        });
      },
    );
  }
}
