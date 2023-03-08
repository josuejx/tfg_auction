import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_auction/controllers/home_controller.dart';
import 'package:tfg_auction/screens/home_screen.dart';

class AuctiOnBottomBar extends StatefulWidget {
  @override
  State<AuctiOnBottomBar> createState() => _AuctiOnBottomBarState();
}

class _AuctiOnBottomBarState extends State<AuctiOnBottomBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: 'Categorías',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Mis pujas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.archive),
          label: 'Archivado',
        ),
      ],
      currentIndex: _selectedIndex,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.shifting,
      unselectedItemColor: Colors.black,
      selectedItemColor: Colors.blue,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
          Get.find<HomeController>().selectedIndex = index;
        });
      },
    );
  }
}
