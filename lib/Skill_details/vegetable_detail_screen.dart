// lib/Skill_details/vegetable_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../theme.dart';

class VegetableDetailScreen extends StatefulWidget {
  @override
  _VegetableDetailScreenState createState() => _VegetableDetailScreenState();
}

class _VegetableDetailScreenState extends State<VegetableDetailScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose of the audio player when done
    super.dispose();
  }

  List<Map<String, String>> get images => [
        {
          'path': 'assets/images/skills/vegetables/carrot.jpg',
          'audio': 'assets/audio/skills/vegetables/carrot.mp3'
        },
        {
          'path': 'assets/images/skills/vegetables/tomato.jpg',
          'audio': 'assets/audio/skills/vegetables/tomato.mp3'
        },
        {
          'path': 'assets/images/skills/vegetables/chili.jpg',
          'audio': 'assets/audio/skills/vegetables/chili.mp3'
        },
        {
          'path': 'assets/images/skills/vegetables/lemon.jpg',
          'audio': 'assets/audio/skills/vegetables/lemon.mp3'
        },
        {
          'path': 'assets/images/skills/vegetables/beetroot.jpg',
          'audio': 'assets/audio/skills/vegetables/beetroot.mp3'
        },
        {
          'path': 'assets/images/skills/vegetables/brocoli.jpg',
          'audio': 'assets/audio/skills/vegetables/brocoli.mp3'
        },
        {
          'path': 'assets/images/skills/vegetables/cauliflower.jpg',
          'audio': 'assets/audio/skills/vegetables/cauliflower.mp3'
        },
        {
          'path': 'assets/images/skills/vegetables/corn.jpg',
          'audio': 'assets/audio/skills/vegetables/corn.mp3'
        },
        {
          'path': 'assets/images/skills/vegetables/cucumbur.jpg',
          'audio': 'assets/audio/skills/vegetables/cucumbur.mp3'
        },
        {
          'path': 'assets/images/skills/vegetables/garlic.jpg',
          'audio': 'assets/audio/skills/vegetables/garlic.mp3'
        },
        {
          'path': 'assets/images/skills/vegetables/ginger.jpg',
          'audio': 'assets/audio/skills/vegetables/ginger.mp3'
        },
        {
          'path': 'assets/images/skills/vegetables/lettuce.jpg',
          'audio': 'assets/audio/skills/vegetables/lettuce.mp3'
        },
        {
          'path': 'assets/images/skills/vegetables/mushroom.jpg',
          'audio': 'assets/audio/skills/vegetables/mushroom.mp3'
        },
        {
          'path': 'assets/images/skills/vegetables/okra.jpg',
          'audio': 'assets/audio/skills/vegetables/okra.mp3'
        },
        {
          'path': 'assets/images/skills/vegetables/onion.jpg',
          'audio': 'assets/audio/skills/vegetables/onion.mp3'
        },
        {
          'path': 'assets/images/skills/vegetables/peas.jpg',
          'audio': 'assets/audio/skills/vegetables/peas.mp3'
        },
        {
          'path': 'assets/images/skills/vegetables/potato.jpg',
          'audio': 'assets/audio/skills/vegetables/potato.mp3'
        },
        {
          'path': 'assets/images/skills/vegetables/sweetpotato.jpg',
          'audio': 'assets/audio/skills/vegetables/sweetpotato.mp3'
        },
        {
          'path': 'assets/images/skills/vegetables/eggplant.jpg',
          'audio': 'assets/audio/skills/vegetables/eggplant.mp3'
        },
        {
          'path': 'assets/images/skills/vegetables/cabbage.jpg',
          'audio': 'assets/audio/skills/vegetables/cabbage.mp3'
        },
        {
          'path': 'assets/images/skills/vegetables/zucchini.jpg',
          'audio': 'assets/audio/skills/vegetables/zucchini.mp3'
        },
        {
          'path': 'assets/images/skills/vegetables/turnip.jpg',
          'audio': 'assets/audio/skills/vegetables/turnip.mp3'
        },
        {
          'path': 'assets/images/skills/vegetables/taro.jpg',
          'audio': 'assets/audio/skills/vegetables/taro.mp3'
        },
        {
          'path': 'assets/images/skills/vegetables/spinach.jpg',
          'audio': 'assets/audio/skills/vegetables/spinach.mp3'
        },
        {
          'path': 'assets/images/skills/vegetables/parsley.jpg',
          'audio': 'assets/audio/skills/vegetables/parsley.mp3'
        },
        {
          'path': 'assets/images/skills/vegetables/molokhia.jpg',
          'audio': 'assets/audio/skills/vegetables/molokhia.mp3'
        },
        {
          'path': 'assets/images/skills/vegetables/artichock.jpg',
          'audio': 'assets/audio/skills/vegetables/artichock.mp3'
        },
        {
          'path': 'assets/images/skills/vegetables/avocado.jpg',
          'audio': 'assets/audio/skills/vegetables/avocade.mp3'
        },
        // Add more vegetables as needed
      ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('خضراوات'),
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
