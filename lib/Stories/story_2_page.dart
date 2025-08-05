import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/scheduler.dart'; // For the frame callback

import '../theme.dart'; // Import your theme file (adjust the path if necessary)

class Story2Page extends StatefulWidget {
  final bool isChildModeActive;
  final bool isDarkModeActive;
  final void Function(bool) toggleDarkMode;
  final void Function(bool) toggleChildMode;

  const Story2Page({
    required this.isChildModeActive,
    required this.isDarkModeActive,
    required this.toggleDarkMode,
    required this.toggleChildMode,
  });

  @override
  _Story1PageState createState() => _Story1PageState();
}

class _Story1PageState extends State<Story2Page> {
  late AudioPlayer _audioPlayer;
  double _progress = 0.0;
  late Duration _audioDuration;
  final ScrollController _scrollController = ScrollController();
  bool _isPlaying = false; // Flag to track play state

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    _audioPlayer.setAsset('assets/audio/story_2.mp3').then((_) {
      _audioPlayer.durationStream.listen((duration) {
        if (duration != null) {
          setState(() {
            _audioDuration = duration;
          });
        }
      });
    });

    _audioPlayer.positionStream.listen((position) {
      setState(() {
        _progress = position.inMilliseconds / (_audioDuration.inMilliseconds);
      });
      // Scroll down as the audio progresses
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _scrollController
            .jumpTo(_scrollController.position.maxScrollExtent * _progress);
      });
    });

    _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        _isPlaying = state.playing;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use the appropriate theme based on dark mode
    final ThemeData theme = widget.isDarkModeActive ? darkTheme : lightTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'قصة الفأر المغرور',
          style: theme.appBarTheme.titleTextStyle,
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        // Removed the actions property to hide the button
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: widget.isDarkModeActive
              ? darkPrimaryGradient // Apply dark gradient
              : lightPrimaryGradient, // Apply light gradient
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'قصة الفأر المغرور',
              style: theme.textTheme.displayLarge?.copyWith(
                color: widget.isDarkModeActive ? Colors.white : Colors.black,
              ),
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 20), // Spacing for audio icon
            IconButton(
              icon: Icon(Icons.play_circle_outline),
              iconSize: 48,
              color: widget.isDarkModeActive ? Colors.white : Colors.black,
              onPressed: () async {
                await _audioPlayer.play();
              },
            ),
            const SizedBox(height: 20), // Spacing for progress bar
            if (_isPlaying) // Show progress bar only when playing
              Slider(
                value: _progress,
                onChanged: (value) {
                  setState(() {
                    _progress = value;
                  });
                  final position = Duration(
                      milliseconds:
                          (value * _audioDuration.inMilliseconds).toInt());
                  _audioPlayer.seek(position);
                },
                min: 0.0,
                max: 1.0,
                activeColor:
                    widget.isDarkModeActive ? Colors.white : Colors.black,
                inactiveColor:
                    widget.isDarkModeActive ? Colors.grey : Colors.grey[400],
              ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Text(
                  ''' ''',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 18,
                    color:
                        widget.isDarkModeActive ? Colors.white : Colors.black,
                  ),
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
