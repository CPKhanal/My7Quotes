import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MusicToggleButton extends StatefulWidget {
  const MusicToggleButton({super.key});

  @override
  State<MusicToggleButton> createState() => _MusicToggleButtonState();
}

class _MusicToggleButtonState extends State<MusicToggleButton> {
  final AudioPlayer _player = AudioPlayer();

  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _setup();
  }

  Future<void> _setup() async {
    try {
      await _player.setAsset('assets/audio/music.mp3');
      await _player.setLoopMode(LoopMode.all);

      // Sync actual player state with UI
      _player.playerStateStream.listen((state) {
        setState(() {
          _isPlaying = state.playing;
        });
      });
    } catch (e) {
      print('Audio error: $e');
    }
  }

  void _toggleMusic() async {
    if (_isPlaying) {
      await _player.pause();
    } else {
      await _player.play();
    }
    // No setState here — the stream listener handles it
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isPlaying ? Icons.music_off : Icons.music_note,
        color: Colors.white,
      ),
      tooltip: _isPlaying ? 'Pause music' : 'Play music',
      onPressed: _toggleMusic,
    );
  }
}
