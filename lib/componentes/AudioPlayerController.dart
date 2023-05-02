import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerController extends ChangeNotifier with WidgetsBindingObserver {
  AudioPlayer audioPlayer;

  AudioPlayerController({required this.audioPlayer}) {
    WidgetsBinding.instance?.addObserver(this);
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
      // Cuando la aplicación regresa a primer plano, reanuda la reproducción.
        audioPlayer.resume();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      // Cuando la aplicación pasa a segundo plano, pausa la reproducción.
        audioPlayer.pause();
        break;
    }
  }

  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    audioPlayer.dispose();
    super.dispose();
  }
}
