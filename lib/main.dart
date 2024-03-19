import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';
import 'package:sermoes_wmb_flutter/app.dart';
import 'package:sermoes_wmb_flutter/app/player/player_provider.dart';

void main() async {
  await JustAudioBackground.init(
      androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
  );
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (contex) => PlayerProvider())
    ], child: const App()),
  );
}

