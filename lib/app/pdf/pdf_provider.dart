import 'package:flutter/material.dart';
import 'package:sermoes_wmb_flutter/app/player/playerType.dart';
import 'package:sermoes_wmb_flutter/sermoes.dart';

class PdfProvider extends ChangeNotifier {

  late List<PlayerType> _listDatas = datas;

  late PlayerType _currentData = PlayerType(
      audio: '', audio_en: '', details: '', id: '', pdf: '', title: '');

  PlayerType get currentData => _currentData;

  set setCurrentId(String id) {
    PlayerType data = _listDatas.firstWhere((element) => element.id == id);
    _currentData = data;
    notifyListeners();
  }
}
