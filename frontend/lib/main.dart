import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/theme/theme_data.dart';
import 'package:frontend/presentation/routes/routes.dart';
import 'package:provider/provider.dart';
import 'provider/main_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => MainProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: CustomThemeData.themeData,
    );
  }
}
