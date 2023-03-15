import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_auction/controllers/home_controller.dart';
import 'package:tfg_auction/screens/home_screens_content/bid_content.dart';
import 'package:tfg_auction/widgets/layout/auction_appbar.dart';
import 'package:tfg_auction/widgets/layout/auction_drawer.dart';
import 'package:tfg_auction/widgets/layout/bottom_bar.dart';

import 'home_screens_content/category_content.dart';
import 'home_screens_content/home_content.dart';
import 'home_screens_content/saved_content.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);

  HomeController homeController = Get.put(HomeController());

  final _screens = [
    HomeContent(),
    const CategoryContent(),
    const BidContent(),
    const SavedContent(),
  ];

  @override
  Widget build(BuildContext context) {
    return AuctiOnDrawer(
      child: Scaffold(
        appBar: const AuctiOnAppBar(),
        bottomNavigationBar: AuctiOnBottomBar(),
        body: Obx(() => _screens[controller.selectedIndex]),
      ),
    );
  }
}
