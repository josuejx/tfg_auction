import 'package:flutter/material.dart';
import 'package:tfg_auction/global.dart';
import 'package:tfg_auction/widgets/layout/my_search_delegate.dart';

class AuctiOnAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AuctiOnAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('AuctiOn'),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Globals.advancedDrawerController.showDrawer();
        },
        icon: const Icon(Icons.menu),
      ),
      actions: [
        IconButton(
          onPressed: () {
            showSearch(context: context, delegate: MySearchDelegate());
          },
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
