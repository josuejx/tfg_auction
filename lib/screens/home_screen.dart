import 'package:flutter/material.dart';
import 'package:tfg_auction/widgets/auction_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AuctiOnAppBar(),
      body: Center(
        child: Text('HomeScreen'),
      ),
    );
  }
}
