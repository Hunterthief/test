// lib/Skill_details/animal_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../theme.dart'; // Assuming theme.dart contains your light and dark mode styles

class AnimalDetailScreen extends StatefulWidget {
  @override
  _AnimalDetailScreenState createState() => _AnimalDetailScreenState();
}

class _AnimalDetailScreenState extends State<AnimalDetailScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose the audio player when done
    super.dispose();
  }

  // List of images and their respective audio files
  List<Map<String, String>> get images => [
        {
          'path': 'assets/images/skills/animals/bird.jpeg',
          'audio': 'assets/audio/skills/animals/bird.mp3'
        },
        {
          'path': 'assets/images/skills/animals/camel.jpeg',
          'audio': 'assets/audio/skills/animals/camel.mp3'
        },
        {
          'path': 'assets/images/skills/animals/chicken.jpg',
          'audio': 'assets/audio/skills/animals/chicken.mp3'
        },
        {
          'path': 'assets/images/skills/animals/cow.jpeg',
          'audio': 'assets/audio/skills/animals/cow.mp3'
        },
        {
          'path': 'assets/images/skills/animals/dog.jpeg',
          'audio': 'assets/audio/skills/animals/dog.mp3'
        },
        {
          'path': 'assets/images/skills/animals/fish.jpeg',
          'audio': 'assets/audio/skills/animals/fish.mp3'
        },
        {
          'path': 'assets/images/skills/animals/rabbit.jpeg',
          'audio': 'assets/audio/skills/animals/rabbit.mp3'
        },
        {
          'path': 'assets/images/skills/animals/sheep.jpeg',
          'audio': 'assets/audio/skills/animals/sheep.mp3'
        },
        {
          'path': 'assets/images/skills/animals/chameleon.jpg',
          'audio': 'assets/audio/skills/animals/chameleon.mp3'
        },
        {
          'path': 'assets/images/skills/animals/zebra.jpg',
          'audio': 'assets/audio/skills/animals/zebra.mp3'
        },
        {
          'path': 'assets/images/skills/animals/wolf.jpg',
          'audio': 'assets/audio/skills/animals/wolf.mp3'
        },
        {
          'path': 'assets/images/skills/animals/squirrel.jpg',
          'audio': 'assets/audio/skills/animals/squirrel.mp3'
        },
        {
          'path': 'assets/images/skills/animals/rhino.jpg',
          'audio': 'assets/audio/skills/animals/rhino.mp3'
        },
        {
          'path': 'assets/images/skills/animals/rat.jpg',
          'audio': 'assets/audio/skills/animals/rat.mp3'
        },
        {
          'path': 'assets/images/skills/animals/hedgehog.jpg',
          'audio': 'assets/audio/skills/animals/hedgehog.mp3'
        },
        {
          'path': 'assets/images/skills/animals/gorilla.jpg',
          'audio': 'assets/audio/skills/animals/gorilla.mp3'
        },
        {
          'path': 'assets/images/skills/animals/fox.jpg',
          'audio': 'assets/audio/skills/animals/fox.mp3'
        },
        {
          'path': 'assets/images/skills/animals/chick.jpg',
          'audio': 'assets/audio/skills/animals/chick.mp3'
        },
        {
          'path': 'assets/images/skills/animals/duck.jpg',
          'audio': 'assets/audio/skills/animals/duck.mp3'
        },
        {
          'path': 'assets/images/skills/animals/goose.jpg',
          'audio': 'assets/audio/skills/animals/goose.mp3'
        },
        {
          'path': 'assets/images/skills/animals/ostrich.jpg',
          'audio': 'assets/audio/skills/animals/ostrich.mp3'
        },
        {
          'path': 'assets/images/skills/animals/owl.jpg',
          'audio': 'assets/audio/skills/animals/owl.mp3'
        },
        {
          'path': 'assets/images/skills/animals/pigeon.jpg',
          'audio': 'assets/audio/skills/animals/pigeon.mp3'
        },
        {
          'path': 'assets/images/skills/animals/rooster.jpg',
          'audio': 'assets/audio/skills/animals/rooster.mp3'
        },
        {
          'path': 'assets/images/skills/animals/turkey.jpg',
          'audio': 'assets/audio/skills/animals/turkey.mp3'
        },
        {
          'path': 'assets/images/skills/animals/cat.jpg',
          'audio': 'assets/audio/skills/animals/cat.mp3'
        },
        {
          'path': 'assets/images/skills/animals/cheatah.jpg',
          'audio': 'assets/audio/skills/animals/cheatah.mp3'
        },
        {
          'path': 'assets/images/skills/animals/deer.jpg',
          'audio': 'assets/audio/skills/animals/deer.mp3'
        },
        {
          'path': 'assets/images/skills/animals/goat.jpg',
          'audio': 'assets/audio/skills/animals/goat.mp3'
        },
        {
          'path': 'assets/images/skills/animals/kangaro.jpg',
          'audio': 'assets/audio/skills/animals/kangaro.mp3'
        },
        {
          'path': 'assets/images/skills/animals/pig.jpg',
          'audio': 'assets/audio/skills/animals/pig.mp3'
        },
        {
          'path': 'assets/images/skills/animals/tiger.jpg',
          'audio': 'assets/audio/skills/animals/tiger.mp3'
        },
        {
          'path': 'assets/images/skills/animals/monkey.jpg',
          'audio': 'assets/audio/skills/animals/monkey.mp3'
        },
        {
          'path': 'assets/images/skills/animals/lion.jpg',
          'audio': 'assets/audio/skills/animals/lion.mp3'
        },
        {
          'path': 'assets/images/skills/animals/horse.jpg',
          'audio': 'assets/audio/skills/animals/horse.mp3'
        },
        {
          'path': 'assets/images/skills/animals/elephant.jpg',
          'audio': 'assets/audio/skills/animals/elephant.mp3'
        },
        {
          'path': 'assets/images/skills/animals/donkey.jpg',
          'audio': 'assets/audio/skills/animals/donkey.mp3'
        },
        {
          'path': 'assets/images/skills/animals/bear.jpg',
          'audio': 'assets/audio/skills/animals/bear.mp3'
        },
        {
          'path': 'assets/images/skills/animals/eagle.jpg',
          'audio': 'assets/audio/skills/animals/eagle.mp3'
        },
        {
          'path': 'assets/images/skills/animals/hippo.jpg',
          'audio': 'assets/audio/skills/animals/hippo.mp3'
        },
        {
          'path': 'assets/images/skills/animals/hog.jpg',
          'audio': 'assets/audio/skills/animals/hog.mp3'
        },
        {
          'path': 'assets/images/skills/animals/hyaena.jpg',
          'audio': 'assets/audio/skills/animals/hyaena.mp3'
        },
        {
          'path': 'assets/images/skills/animals/peacock.jpg',
          'audio': 'assets/audio/skills/animals/peacock.mp3'
        },
        {
          'path': 'assets/images/skills/animals/crocodile.jpg',
          'audio': 'assets/audio/skills/animals/crocodile.mp3'
        },
        {
          'path': 'assets/images/skills/animals/dolpine.jpg',
          'audio': 'assets/audio/skills/animals/dolpine.mp3'
        },
        {
          'path': 'assets/images/skills/animals/turtle.jpg',
          'audio': 'assets/audio/skills/animals/turtle.mp3'
        },
        // Add more animals as needed
      ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('حيوانات'),
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
