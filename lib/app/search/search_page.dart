import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sermoes_wmb_flutter/app/player/playerType.dart';
import 'package:sermoes_wmb_flutter/app/player/player_provider.dart';
import 'package:sermoes_wmb_flutter/app/widget/card.dart';

// import 'package:sermoes_wmb_flutter/sermoes.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _controller;
  late final dynamic playListProvider;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    playListProvider = Provider.of<PlayerProvider>(context, listen: false);
  }

  void filterPlayers(String title) {
    playListProvider.filterPlayerByTitle(title);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Consumer<PlayerProvider>(
      builder: (context, value, child) {
        final List<PlayerType> allDatas = value.allDatas;

        return Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Center(
                child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: TextField(
                style:
                    TextStyle(color: Theme.of(context).colorScheme.background),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Procure por um título',
                    prefixIcon: Icon(Icons.search,
                        color: Color.fromRGBO(19, 21, 24, 0.965))),
                controller: _controller,
                onSubmitted: filterPlayers,
              ),
            )),
            const SizedBox(height: 20.0),
            Expanded(
              child: !allDatas.isEmpty
                  ? ListView.builder(
                      itemCount: allDatas.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return CardView(
                          title: allDatas[index].title,
                          audio: !allDatas[index].audio.isEmpty,
                          pdf: allDatas[index].pdf,
                          id: allDatas[index].id,
                        );
                      },
                    )
                  : const Text(
                      'Nenhum Resultado...',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16.0),
                    ),
            )
          ],
        );
      },
    ));
  }
}
