import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:sermoes_wmb_flutter/app/player/playerType.dart';
import 'package:sermoes_wmb_flutter/sermoes.dart';

class PlayerProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  late List<PlayerType> _listDatas = datas;
  late PlayerType _currentData = PlayerType(
      audio: '', audio_en: '', details: '', id: '', pdf: '', title: '');
  late Duration _totalDuration = Duration.zero;
  late Duration _currentDuration = Duration.zero;
  late bool _isPlaying = false;
  late bool _loading = true;
  late double _rate = 1.0;
  late bool _isFavorite = false;
  int _selectedPlayer = 1;

  PlayerProvider() {
    listenToDuration();
  }

  void playPt() async {
    AudioSource audioSource = AudioSource.uri(Uri.parse(_currentData.audio),
        tag: MediaItem(id: _currentData.id,
        title: _currentData.title,
        artUri: Uri.file('/assets/images/wbranham.png')
        ));

    _loading = true;
    await _audioPlayer.stop();
    await _audioPlayer.setAudioSource(audioSource);
    _selectedPlayer = 1;
    _isPlaying = false;
    _currentDuration = Duration.zero;
    _loading = false;
    notifyListeners();
  }

  void playEn() async {
     AudioSource audioSource = AudioSource.uri(Uri.parse(_currentData.audio_en),
        tag: MediaItem(id: _currentData.id,
        title: _currentData.title,
        artUri: Uri.file('/assets/images/wbranham.png')
        ));
    _loading = true;
    await _audioPlayer.stop();
    await _audioPlayer.setAudioSource(audioSource);
    _selectedPlayer = 2;
    _isPlaying = false;
    _currentDuration = Duration.zero;
    _loading = false;
    notifyListeners();
  }

  void pause() async {
    _isPlaying = false;
    await _audioPlayer.pause();
    notifyListeners();
  }

  void play() async {
    _isPlaying = true;
    await _audioPlayer.play();
    notifyListeners();
  }

  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      play();
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
      await _audioPlayer.setSpeed(1.5);
      _rate = 1.5;
    } else if (_rate == 1.5) {
      await _audioPlayer.setSpeed(2.0);
      _rate = 2.0;
    } else if (_rate == 2.0) {
      await _audioPlayer.setSpeed(0.5);
      _rate = 0.5;
    } else if (_rate == 0.5) {
      await _audioPlayer.setSpeed(1.0);
      _rate = 1.0;
    }
    if (!_isPlaying) {
      await _audioPlayer.pause();
    }
    notifyListeners();
  }

  void playerDispose() async {
    await _audioPlayer.stop();
    // await _audioPlayer.dispose();
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
    _audioPlayer.durationStream.listen((event) {
      _totalDuration = event!;
      notifyListeners();
    });

    _audioPlayer.positionStream.listen((event) {
      _currentDuration = event;
      notifyListeners();
    });

    // _audioPlayer.p.listen((event) {
    //   _isPlaying = false;
    //   notifyListeners();
    // });
  }

  void toggleFavorite() {
    if (_isFavorite) {
      _isFavorite = false;
    } else {
      _isFavorite = true;
    }
    notifyListeners();
  }

  void togglePlayer(int int) {
    if (int == 1 && _selectedPlayer != 1 && _currentData.audio.isNotEmpty) {
      playPt();
      _selectedPlayer = 1;
    } else if (_currentData.audio_en.isNotEmpty &&
        _selectedPlayer != 2 &&
        int == 2) {
      playEn();
      _selectedPlayer = 2;
    }
    notifyListeners();
  }

  List<PlayerType> get allDatas => _listDatas;
  PlayerType get currentData => _currentData;
  bool get isPlaying => _isPlaying;
  bool get loading => _loading;
  Duration get totalDuration => _totalDuration;
  Duration get currentDuration => _currentDuration;
  double get currentRate => _rate;
  bool get isFavorite => _isFavorite;
  int get selectedPlayer => _selectedPlayer;
  AudioPlayer get player => _audioPlayer;

  set setCurrentId(String id) {
    PlayerType data = _listDatas.firstWhere((element) => element.id == id);
    _currentData = data;

    if (data.audio.isNotEmpty) {
      playPt();
    } else {
      playEn();
    }

    notifyListeners();
  }
}
