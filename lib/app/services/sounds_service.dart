import 'package:audioplayers/audioplayers.dart';

class SoundService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playBlo9() async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('boblo.wav'),
        mode: PlayerMode.lowLatency);
  }

  Future<void> playDodov() async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('dodov.wav'),
        mode: PlayerMode.lowLatency);
  }

  Future<void> playKsek() async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('ksek.wav'));
  }

  Future<void> playTess() async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('tess.wav'));
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
