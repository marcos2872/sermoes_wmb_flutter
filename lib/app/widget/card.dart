import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routefly/routefly.dart';
import 'package:sermoes_wmb_flutter/app/player/player_provider.dart';
import 'package:sermoes_wmb_flutter/routes.dart';

class CardView extends StatefulWidget {
  final String title;
  final bool audio;
  final String pdf;
  final String id;

  const CardView(
      {super.key,
      required this.title,
      required this.audio,
      required this.pdf,
      required this.id});

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  late final dynamic playListProvider;

  @override
  void initState() {
    super.initState();
    playListProvider = Provider.of<PlayerProvider>(context, listen: false);
  }

  void goPlay() {
    playListProvider.setCurrentId = widget.id;

    Routefly.push(routePaths.player.$id.changes({'id': widget.id}));
  }

  void goPdf() {
    Routefly.push(routePaths.pdf.$id.changes({'id': widget.id}));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      width: MediaQuery.of(context).size.width - 10.0,
      height: 100.0,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 15.0),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: goPlay,
                  child: Icon(
                    Icons.audiotrack_rounded,
                    size: 25.0,
                    color: widget.audio
                        ? Theme.of(context).colorScheme.surface
                        : Theme.of(context).colorScheme.secondary,
                  )),
              const SizedBox(
                width: 20.0,
              ),
              TextButton(
                  onPressed: goPdf,
                  child: Icon(
                    Icons.picture_as_pdf_rounded,
                    size: 25.0,
                    color: Theme.of(context).colorScheme.surface,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
