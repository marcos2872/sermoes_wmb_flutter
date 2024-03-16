import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sermoes_wmb_flutter/app.dart';
import 'package:sermoes_wmb_flutter/app/player/player_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (contex) => PlayerProvider())
      ],
      child: const App()
    ),
  );
}
