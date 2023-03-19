import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;
  set selectedIndex(int index) => _selectedIndex.value = index;

  final icons = [
    Icons.home,
    Icons.category,
    Icons.shopping_cart,
    Icons.favorite,
  ];

  final labels = [
    'Home',
    'Category',
    'Bid',
    'Saved',
  ];
}
