import 'package:flutter/material.dart';
import 'package:tfg_auction/widgets/layout/auction_appbar.dart';
import 'package:tfg_auction/widgets/layout/auction_drawer.dart';
import 'package:tfg_auction/widgets/layout/bottom_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuctiOnDrawer(
      child: Scaffold(
        appBar: const AuctiOnAppBar(),
        bottomNavigationBar: AuctiOnBottomBar(),
        body: const Center(
          child: Text('HomeScreen'),
        ),
      ),
    );
  }
}
