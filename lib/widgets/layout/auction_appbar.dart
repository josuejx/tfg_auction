import 'package:flutter/material.dart';
import 'package:tfg_auction/widgets/layout/my_search_delegate.dart';

class AuctiOnAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AuctiOnAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Hero(
        tag: 'logo',
        child: Image.asset(
          'assets/logo_fondo.png',
          height: 40,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            showSearch(context: context, delegate: MySearchDelegate());
          },
          icon: const Icon(Icons.search),
        ),
      ],
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
