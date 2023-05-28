import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../config/app_router.dart';
import '../widgets/text_liquid_widget.dart';

class SplashScreenPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: TextLiquidWidget(
            text: "NEWS",
            waveDuration: const Duration(seconds: 2),
            loadDuration: const Duration(),
            completeAction: () {
              appRouter.replace(const BreakingNewsRoute());
            },
            waveColor: Colors.white,
            textStyle:
                const TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
            height: 300.0,
          ),
        ),
      ),
    );
  }
}
