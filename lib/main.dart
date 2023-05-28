import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import 'src/config/app_router.dart';
import 'src/config/app_theme.dart';
import 'src/injector.dart';
import 'src/utils/constants/strings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
      title: kAppTitle,
      theme: AppTheme.light,
    ));
  }
}
