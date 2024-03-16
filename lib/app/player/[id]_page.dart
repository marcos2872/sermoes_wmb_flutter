import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:routefly/routefly.dart';
import 'package:sermoes_wmb_flutter/app/player/player_provider.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late final dynamic playListProvider;

  @override
  void initState() {
    super.initState();
    playListProvider = Provider.of<PlayerProvider>(context, listen: false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    playListProvider.playerDispose();
  }

  String formatTime(Duration duration) {
    String twoDigitalSeconds = duration.inSeconds.remainder(60).toString();
    String twoDigitalMinutes = duration.inMinutes.remainder(60).toString();
    String formattedTime =
        '${duration.inHours}:$twoDigitalMinutes:$twoDigitalSeconds';

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            leading: TextButton(
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Color.fromRGBO(255, 255, 255, 100),
              ),
              onPressed: () {
                Routefly.pop(context);
              },
            )),
        body: Consumer<PlayerProvider>(
          builder: (context, value, child) {
            return SafeArea(
                child: value.loading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Color.fromRGBO(118, 171, 174, 10),
                      ))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(200.0),
                              child: Image(
                                image:
                                    const AssetImage('assets/images/wmb.png'),
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width - 50.0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              value.currentData.title,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15.0),
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  formatTime(value.currentDuration),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  formatTime(value.totalDuration),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                  thumbShape: const RoundSliderThumbShape(
                                      enabledThumbRadius: 0),
                                  inactiveTrackColor:
                                      Theme.of(context).colorScheme.onTertiary),
                              child: Slider(
                                max: value.totalDuration.inSeconds.toDouble(),
                                min: 0,
                                value:
                                    value.currentDuration.inSeconds.toDouble(),
                                activeColor:
                                    Theme.of(context).colorScheme.onSurface,
                                onChanged: (double double) {},
                                onChangeEnd: (double double) {
                                  value.seek(Duration(seconds: double.toInt()));
                                },
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 10),
                              TextButton(
                                onPressed: value.rate,
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith((states) =>
                                          Theme.of(context)
                                              .colorScheme
                                              .onSurface),
                                  minimumSize: MaterialStateProperty.all(
                                      const Size(40, 40)),
                                  // alignment: Alignment.center
                                ),
                                child: Text(
                                  '${value.currentRate}x',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(width: 10),
                              TextButton(
                                onPressed: () =>
                                    value.rewindSeek(value.currentDuration),
                                child: Icon(
                                  Icons.fast_rewind_rounded,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  size: 50.0,
                                ),
                              ),
                              const SizedBox(width: 5),
                              TextButton(
                                onPressed: value.pauseOrResume,
                                child: Icon(
                                  value.isPlaying
                                      ? Icons.pause_circle_rounded
                                      : Icons.play_circle_rounded,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  size: 50.0,
                                ),
                              ),
                              const SizedBox(width: 5),
                              TextButton(
                                onPressed: () =>
                                    value.forwardSeek(value.currentDuration),
                                child: Icon(
                                  Icons.fast_forward_rounded,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  size: 50.0,
                                ),
                              ),
                              const SizedBox(width: 10),
                              TextButton(
                                onPressed: value.toggleFavorite,
                                child: Icon(
                                  value.isFavorite
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_outline_rounded,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  size: 30.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ));
          },
        ));
  }
}
