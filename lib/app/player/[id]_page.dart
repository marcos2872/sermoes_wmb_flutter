import 'package:flutter/material.dart';
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
                          const SizedBox(height: 30.0),
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
                                SizedBox(
                                  width: 60,
                                  // child: Center(
                                  child: Text(
                                    formatTime(value.currentDuration),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                  ),
                                  // ),
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) =>
                                                      value.selectedPlayer == 1
                                                          ? Theme.of(context)
                                                              .colorScheme
                                                              .surface
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .onSurface),
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  const Size(40, 40)),
                                        ),
                                        onPressed: () => value.togglePlayer(1),
                                        child: const Text('Pt-br')),
                                    const SizedBox(width: 10.0),
                                    TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) =>
                                                      value.selectedPlayer == 2
                                                          ? Theme.of(context)
                                                              .colorScheme
                                                              .surface
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .onSurface),
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  const Size(40, 40)),
                                        ),
                                        onPressed: () => value.togglePlayer(2),
                                        child: const Text('En-us')),
                                  ],
                                ),
                                SizedBox(
                                  width: 60,
                                  // child: Center(
                                  child: Text(
                                    formatTime(value.totalDuration),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.end,
                                  ),
                                  // ),
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
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 50.0,
                                  child: ElevatedButton(
                                    onPressed: value.rate,
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateColor.resolveWith(
                                                (states) => Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                        fixedSize: MaterialStateProperty.all(
                                            const Size(50, 50)),
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.zero)),
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
                                ),
                                IconButton(
                                  onPressed: () =>
                                      value.rewindSeek(value.currentDuration),
                                  icon: Icon(
                                    Icons.fast_rewind_rounded,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    size: 50.0,
                                  ),
                                ),
                                IconButton(
                                  onPressed: value.pauseOrResume,
                                  icon: Icon(
                                    value.isPlaying
                                        ? Icons.pause_circle_rounded
                                        : Icons.play_circle_rounded,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    size: 50.0,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      value.forwardSeek(value.currentDuration),
                                  icon: Icon(
                                    Icons.fast_forward_rounded,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    size: 50.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 50.0,
                                  child: ElevatedButton(
                                    onPressed: value.toggleFavorite,
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateColor.resolveWith(
                                                (states) => Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                        // minimumSize: MaterialStateProperty.all(
                                        //     const Size(40, 40)),
                                        fixedSize: MaterialStateProperty.all(
                                            const Size(50, 50)),
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.zero)
                                        // alignment: Alignment.center,
                                        ),
                                    child: Icon(
                                      value.isFavorite
                                          ? Icons.favorite_rounded
                                          : Icons.favorite_outline_rounded,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      size: 30.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ));
          },
        ));
  }
}
