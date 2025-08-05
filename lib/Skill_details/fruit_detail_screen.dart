// lib/Skill_details/fruit_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../theme.dart';

class FruitDetailScreen extends StatefulWidget {
  @override
  _FruitDetailScreenState createState() => _FruitDetailScreenState();
}

class _FruitDetailScreenState extends State<FruitDetailScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose of the audio player when done
    super.dispose();
  }

  List<Map<String, String>> get images => [
        {
          'path': 'assets/images/skills/fruits/apple.jpg',
          'audio': 'assets/audio/skills/fruits/apple.mp3'
        },
        {
          'path': 'assets/images/skills/fruits/banana.jpg',
          'audio': 'assets/audio/skills/fruits/banana.mp3'
        },
        {
          'path': 'assets/images/skills/fruits/cherry.jpg',
          'audio': 'assets/audio/skills/fruits/cherry.mp3'
        },
        {
          'path': 'assets/images/skills/fruits/coconut.jpg',
          'audio': 'assets/audio/skills/fruits/coconut.mp3'
        },
        {
          'path': 'assets/images/skills/fruits/grapes.jpg',
          'audio': 'assets/audio/skills/fruits/grapes.mp3'
        },
        {
          'path': 'assets/images/skills/fruits/kiwi.jpg',
          'audio': 'assets/audio/skills/fruits/kiwi.mp3'
        },
        {
          'path': 'assets/images/skills/fruits/orange.jpg',
          'audio': 'assets/audio/skills/fruits/orange.mp3'
        },
        {
          'path': 'assets/images/skills/fruits/peach.jpg',
          'audio': 'assets/audio/skills/fruits/peach.mp3'
        },
        {
          'path': 'assets/images/skills/fruits/pears.jpg',
          'audio': 'assets/audio/skills/fruits/pears.mp3'
        },
        {
          'path': 'assets/images/skills/fruits/plum.jpg',
          'audio': 'assets/audio/skills/fruits/plum.mp3'
        },
        {
          'path': 'assets/images/skills/fruits/pomegranate.jpg',
          'audio': 'assets/audio/skills/fruits/pomegranate.mp3'
        },
        {
          'path': 'assets/images/skills/fruits/strawberry.jpg',
          'audio': 'assets/audio/skills/fruits/strawberry.mp3'
        },
        {
          'path': 'assets/images/skills/fruits/tangerine.jpg',
          'audio': 'assets/audio/skills/fruits/tangerine.mp3'
        },

        {
          'path': 'assets/images/skills/fruits/watermelon.jpg',
          'audio': 'assets/audio/skills/fruits/watermelon.mp3'
        },
        {
          'path': 'assets/images/skills/fruits/cantalop.jpg',
          'audio': 'assets/audio/skills/fruits/cantalop.mp3'
        },
        {
          'path': 'assets/images/skills/fruits/pumpkin.jpg',
          'audio': 'assets/audio/skills/fruits/pumpkin.mp3'
        },
        {
          'path': 'assets/images/skills/fruits/apricot.jpg',
          'audio': 'assets/audio/skills/fruits/apricot.mp3'
        },
        {
          'path': 'assets/images/skills/fruits/guava.jpg',
          'audio': 'assets/audio/skills/fruits/guava.mp3'
        },
        {
          'path': 'assets/images/skills/fruits/mango.jpg',
          'audio': 'assets/audio/skills/fruits/mango.mp3'
        },
        {
          'path': 'assets/images/skills/fruits/berry.jpg',
          'audio': 'assets/audio/skills/fruits/berry.mp3'
        },
        {
          'path': 'assets/images/skills/fruits/pineapple.jpg',
          'audio': 'assets/audio/skills/fruits/pineapple.mp3'
        }, // Add more fruits as needed
      ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('فواكه'),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDarkMode ? darkModeContainerGradient : null,
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
          ),
          itemCount: images.length,
          itemBuilder: (context, index) {
            final image = images[index];
            return GestureDetector(
              onTap: () {
                _onImageTap(context, image['path']!, image['audio']!);
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image['path']!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onImageTap(
      BuildContext context, String imagePath, String audioPath) async {
    // Check if the audio file exists
    try {
      // Try setting the audio; this will throw an exception if the file doesn't exist
      await _audioPlayer.setAsset(audioPath);
      // Stop the currently playing audio
      await _audioPlayer.stop();

      // If the audio exists, play it
      _audioPlayer.play();
    } catch (e) {
      print("Audio file not found: $audioPath"); // Handle missing audio
    }

    // Open the image in the dialog regardless of whether the audio exists
    _showDetailDialog(context, imagePath, audioPath);
  }

  void _showDetailDialog(
      BuildContext context, String imagePath, String audioPath) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(imagePath),
            SizedBox(height: 20),
            // Conditionally show the play button if the audio file exists
            FutureBuilder(
              future: _audioPlayer.setAsset(audioPath),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.error == null) {
                  // If the audio file was successfully loaded, show the play button
                  return ElevatedButton(
                    onPressed: () async {
                      // Play the audio every time the button is pressed
                      await _audioPlayer.setAsset(audioPath);
                      _audioPlayer.play();
                    },
                    child: Text('تشغيل الصوت'),
                  );
                } else {
                  // If audio file is missing, display a message (or nothing)
                  return SizedBox
                      .shrink(); // You could also return a message or nothing
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
