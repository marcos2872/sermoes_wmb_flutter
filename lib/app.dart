import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:routefly/routefly.dart';
import 'package:sermoes_wmb_flutter/routes.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(19, 21, 24, 0.965),
        statusBarBrightness: Brightness.dark,
      ),
    );
    return MaterialApp.router(
        routerConfig:
            Routefly.routerConfig(routes: routes, initialPath: routePaths.path),
        debugShowCheckedModeBanner: false,
        color: const Color.fromRGBO(49, 54, 63, 10),
        theme: ThemeData(
            colorScheme: const ColorScheme(
                brightness: Brightness.light,
                primary: Color.fromRGBO(34, 40, 49, 10),
                onPrimary: Color.fromRGBO(34, 40, 49, 100),
                secondary: Color.fromRGBO(49, 54, 63, 10),
                onSecondary: Color.fromRGBO(49, 54, 63, 100),
                tertiary: Colors.white,
                onTertiary: Color.fromRGBO(255, 255, 255, 100),
                error: Colors.red,
                onError: Colors.red,
                background: Color.fromRGBO(19, 21, 24, 0.965),
                onBackground: Color.fromRGBO(34, 37, 41, 0.896),
                surface: Color.fromRGBO(118, 171, 174, 10),
                onSurface: Color.fromRGBO(118, 171, 174, 100),
                )));
  }
}
