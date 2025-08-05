import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../theme.dart'; // Import the theme file

class ClothingDetailScreen extends StatefulWidget {
  @override
  _ClothingDetailScreenState createState() => _ClothingDetailScreenState();
}

class _ClothingDetailScreenState extends State<ClothingDetailScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  List<Map<String, String>> get images => [
        {
          'path': 'assets/images/skills/clothing/belt.jpg',
          'audio': 'assets/audio/skills/clothing/belt.mp3'
        },
        {
          'path': 'assets/images/skills/clothing/blouse.jpg',
          'audio': 'assets/audio/skills/clothing/blouse.mp3'
        },
        {
          'path': 'assets/images/skills/clothing/dress.jpg',
          'audio': 'assets/audio/skills/clothing/dress.mp3'
        },
        {
          'path': 'assets/images/skills/clothing/glasses.jpg',
          'audio': 'assets/audio/skills/clothing/glasses.mp3'
        },
        {
          'path': 'assets/images/skills/clothing/gloves.jpg',
          'audio': 'assets/audio/skills/clothing/gloves.mp3'
        },
        {
          'path': 'assets/images/skills/clothing/junla.jpg',
          'audio': 'assets/audio/skills/clothing/junla.mp3'
        },
        {
          'path': 'assets/images/skills/clothing/touka.jpg',
          'audio': 'assets/audio/skills/clothing/touka.mp3'
        },
        {
          'path': 'assets/images/skills/clothing/under.jpg',
          'audio': 'assets/audio/skills/clothing/under.mp3'
        },
        {
          'path': 'assets/images/skills/clothing/watch.jpg',
          'audio': 'assets/audio/skills/clothing/watch.mp3'
        },
        {
          'path': 'assets/images/skills/clothing/backpack.jpg',
          'audio': 'assets/audio/skills/clothing/backpack.mp3'
        },
        {
          'path': 'assets/images/skills/clothing/jacket.jpg',
          'audio': 'assets/audio/skills/clothing/jacket.mp3'
        },
        {
          'path': 'assets/images/skills/clothing/pullover.jpg',
          'audio': 'assets/audio/skills/clothing/pullover.mp3'
        },
        {
          'path': 'assets/images/skills/clothing/robe.jpg',
          'audio': 'assets/audio/skills/clothing/robe.mp3'
        },
        {
          'path': 'assets/images/skills/clothing/shirt.jpg',
          'audio': 'assets/audio/skills/clothing/shirt.mp3'
        },
        {
          'path': 'assets/images/skills/clothing/short.jpg',
          'audio': 'assets/audio/skills/clothing/short.mp3'
        },
        {
          'path': 'assets/images/skills/clothing/skirt.jpg',
          'audio': 'assets/audio/skills/clothing/skirt.mp3'
        },
        {
          'path': 'assets/images/skills/clothing/sock.jpg',
          'audio': 'assets/audio/skills/clothing/sock.mp3'
        },
        {
          'path': 'assets/images/skills/clothing/t-shirt.jpg',
          'audio': 'assets/audio/skills/clothing/t-shirt.mp3'
        },
      ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('ملابس'),
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
