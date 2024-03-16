import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sermoes_wmb_flutter/app/player/playerType.dart';
import 'package:sermoes_wmb_flutter/sermoes.dart';

class PlayerProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  late List<PlayerType> _listDatas = datas;
  late PlayerType _currentData = new PlayerType(
      audio: '', audio_en: '', details: '', id: '', pdf: '', title: '');
  late Duration _totalDuration = Duration.zero;
  late Duration _currentDuration = Duration.zero;
  late bool _isPlaying = false;
  late bool _loading = true;
  late double _rate = 1.0;
  late bool _isFavorite = false;

  PlayerProvider() {
    listenToDuration();
  }

  void playPt() async {
    _loading = true;
    await _audioPlayer.stop();
    await _audioPlayer.setSourceUrl(_currentData.audio);
    _loading = false;
    notifyListeners();
  }

  void playEn() async {
    _loading = true;
    await _audioPlayer.stop();
    await _audioPlayer.setSourceUrl(_currentData.audio_en);
    _loading = false;
    notifyListeners();
  }

  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void forwardSeek(Duration position) async {
    await _audioPlayer.seek(position + const Duration(seconds: 10));
  }

  void rewindSeek(Duration position) async {
    await _audioPlayer.seek(position - const Duration(seconds: 10));
  }

  void rate() async {
    if (_rate == 1.0) {
      await _audioPlayer.setPlaybackRate(1.5);
      _rate = 1.5;
    } else if (_rate == 1.5) {
      await _audioPlayer.setPlaybackRate(2.0);
      _rate = 2.0;
    } else if (_rate == 2.0) {
      await _audioPlayer.setPlaybackRate(0.5);
      _rate = 0.5;
    } else if (_rate == 0.5) {
      await _audioPlayer.setPlaybackRate(1.0);
      _rate = 1.0;
    }
    if (!_isPlaying) {
      await _audioPlayer.pause();
    }
    notifyListeners();
  }

  void playerDispose() async {
    await _audioPlayer.stop();
    await _audioPlayer.dispose();
    _isPlaying = false;
    notifyListeners();
  }

  void filterPlayerByTitle(String title) {
    _listDatas = datas
        .where((element) =>
            element.title.toLowerCase().contains(title.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((event) {
      _totalDuration = event;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((event) {
      _currentDuration = event;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      _isPlaying = false;
      notifyListeners();
    });
  }

  void toggleFavorite() {
    if (_isFavorite) {
      _isFavorite = true;
    } else {
      _isFavorite = false;
    }
  }

  List<PlayerType> get allDatas => _listDatas;
  PlayerType get currentData => _currentData;
  bool get isPlaying => _isPlaying;
  bool get loading => _loading;
  Duration get totalDuration => _totalDuration;
  Duration get currentDuration => _currentDuration;
  double get currentRate => _rate;
  bool get isFavorite => _isFavorite;

  set setCurrentId(String? id) {
    PlayerType data = _listDatas.firstWhere((element) => element.id == id);
    _currentData = data;

    if (id != null) {
      playPt();
    }
    notifyListeners();
  }
}
