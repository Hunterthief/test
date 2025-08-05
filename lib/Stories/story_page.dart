import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../theme.dart'; // Adjust the import according to your project structure

class StoryPage extends StatelessWidget {
  final String storyTitle;
  final String storyContent;
  final bool isChildModeActive;
  final bool isDarkModeActive;
  final String audioAssetPath; // Path to the audio file in assets

  const StoryPage({
    required this.storyTitle,
    required this.storyContent,
    required this.isChildModeActive,
    required this.isDarkModeActive,
    required this.audioAssetPath,
  });

  @override
  Widget build(BuildContext context) {
    final AudioPlayer audioPlayer = AudioPlayer();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient:
              isDarkModeActive ? darkPrimaryGradient : lightPrimaryGradient,
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              storyTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: isDarkModeActive ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16.0),
            IconButton(
              icon: Icon(Icons.play_circle_outline),
              iconSize: 48,
              color: isDarkModeActive ? Colors.white : Colors.black,
              onPressed: () {
                audioPlayer.play(AssetSource(audioAssetPath));
              },
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  storyContent,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: isDarkModeActive ? Colors.white : Colors.black,
                        fontSize: 18,
                        height: 1.5,
                      ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
