import 'package:flutter/material.dart';

import '../../config/app_router.dart';

class MyAppBar extends AppBar {
  final String titleBar;


  MyAppBar({required this.titleBar})
      : super(
      leading: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => appRouter.pop(),
        child: const Icon(
          Icons.chevron_left,
          color: Colors.black,
        ),
      ),
      title: Text(
        titleBar,
        style: const TextStyle(color: Colors.black),
      )
  ){

  }
}
