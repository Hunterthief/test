// lib/utils/audio_helper.dart
import 'package:just_audio/just_audio.dart';

class AudioHelper {
  final AudioPlayer _player = AudioPlayer();

  Future<void> playButtonSound() async {
    try {
      await _player.setAsset('assets/audio/SFXs/button_sound.mp3');
      _player.play();
    } catch (e) {
      print("Error playing button sound: $e");
    }
  }

  Future<void> playYaySound() async {
    try {
      await _player.setAsset(
          'assets/audio/SFXs/children-yay-sfx.wav'); // Ensure this path is correct
      _player.play();
    } catch (e) {
      print("Error playing yay sound: $e");
    }
  }

  void dispose() {
    _player.dispose();
  }
}
