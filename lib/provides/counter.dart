import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';

class CounterProvider with ChangeNotifier {
  int counter = 0;
  List<String> markers = [
    "00:11.7",
    "00:23.1",
    "00:36.4",
    "00:48.5",
    "01:00.7",
    "01:10.0",
    "01:17.9",
    "01:40.0",
    "02:01.3",
    "02:08.8",
  ];
  List<Duration> dMaekerts = [];
  parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();

    dMaekerts.add(Duration(minutes: minutes, microseconds: micros));
    // dMaekerts.add(Duration(minutes: minutes, microseconds: micros));
    notifyListeners();
    return print('${Duration(minutes: minutes, microseconds: micros)}');
  }

  convert() {
    markers.forEach((element) {
      parseDuration(element);
    });
  }

  // ignore: non_constant_identifier_names
  AudioPlayer player = AudioPlayer();
  Duration duration = Duration.zero;

  void duraction() {
    player.positionStream.listen((event) {
      if (event != null) {
        parseDuration(event.toString());
        // Duration temp = event as Duration;
        // duration = temp;
        // notifyListeners();
        // print('duraction ${event})}');
        // if (dMaekerts
        //     .any((element) => element == event.inSeconds)) {
        //   incrementCounter();
        //   // return;
        // }
      }
    });

// player.durationStream.listen((totalDuration) {
//   final oldState = progressNotifier.value;
//   progressNotifier.value = ProgressBarState(
//     current: oldState.current,
//     buffered: oldState.buffered,
//     total: totalDuration ?? Duration.zero,
//   );
// });
  }

  String formatTime(Duration value) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hour = twoDigits(value.inHours);
    final min = twoDigits(value.inMinutes.remainder(60));
    final sec = twoDigits(value.inSeconds.remainder(60));
    final mic = twoDigits(value.inMilliseconds.remainder(1000000));
    return [if (value.inHours > 0) hour, min, sec, mic].join(':');
  }

  void play() async {
    player.setAudioSource(AudioSource.asset('asset/Audio/003.lite.mp3'));
    // await player.setClip(start: dMaekerts[0], end: dMaekerts[3]);

    await player.play();

    // duraction();
  }

  void stop() async {
    player.setAudioSource(AudioSource.asset('asset/Audio/003.lite.mp3'));
    await player.stop();
  }

  void incrementCounter() {
    counter++;
    notifyListeners();
  }
}
