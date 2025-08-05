import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../theme.dart'; // Import the theme file

class BodyPartsDetailScreen extends StatefulWidget {
  @override
  _BodyPartsDetailScreenState createState() => _BodyPartsDetailScreenState();
}

class _BodyPartsDetailScreenState extends State<BodyPartsDetailScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  List<Map<String, String>> get images => [
        {
          'path': 'assets/images/skills/body_parts/back.jpg',
          'audio': 'assets/audio/skills/body_parts/back.mp3'
        },
        {
          'path': 'assets/images/skills/body_parts/eye_brows.jpg',
          'audio': 'assets/audio/skills/body_parts/eye_brows.mp3'
        },
        {
          'path': 'assets/images/skills/body_parts/eyelash.jpg',
          'audio': 'assets/audio/skills/body_parts/eyelash.mp3'
        },
        {
          'path': 'assets/images/skills/body_parts/eye.jpg',
          'audio': 'assets/audio/skills/body_parts/eye.mp3'
        },
        {
          'path': 'assets/images/skills/body_parts/ear.jpg',
          'audio': 'assets/audio/skills/body_parts/ear.mp3'
        },
        {
          'path': 'assets/images/skills/body_parts/finger.jpg',
          'audio': 'assets/audio/skills/body_parts/finger.mp3'
        },
        {
          'path': 'assets/images/skills/body_parts/foot.jpg',
          'audio': 'assets/audio/skills/body_parts/foot.mp3'
        },
        {
          'path': 'assets/images/skills/body_parts/hair.jpg',
          'audio': 'assets/audio/skills/body_parts/hair.mp3'
        },
        {
          'path': 'assets/images/skills/body_parts/hand.jpg',
          'audio': 'assets/audio/skills/body_parts/hand.mp3'
        },
        {
          'path': 'assets/images/skills/body_parts/knee.jpg',
          'audio': 'assets/audio/skills/body_parts/knee.mp3'
        },
        {
          'path': 'assets/images/skills/body_parts/neck.jpg',
          'audio': 'assets/audio/skills/body_parts/neck.mp3'
        },
        {
          'path': 'assets/images/skills/body_parts/nose.jpg',
          'audio': 'assets/audio/skills/body_parts/nose.mp3'
        },
        {
          'path': 'assets/images/skills/body_parts/stomach.jpg',
          'audio': 'assets/audio/skills/body_parts/stomach.mp3'
        },
        {
          'path': 'assets/images/skills/body_parts/tongue.jpg',
          'audio': 'assets/audio/skills/body_parts/tongue.mp3'
        },
        {
          'path': 'assets/images/skills/body_parts/mouth.jpg',
          'audio': 'assets/audio/skills/body_parts/mouth.mp3'
        },
      ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('أجزاء الجسم'),
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
