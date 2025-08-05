import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../theme.dart'; // Import the theme file

class InsectsDetailScreen extends StatefulWidget {
  @override
  _InsectsDetailScreenState createState() => _InsectsDetailScreenState();
}

class _InsectsDetailScreenState extends State<InsectsDetailScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  List<Map<String, String>> get images => [
        {
          'path': 'assets/images/skills/insects/bee.jpg',
          'audio': 'assets/audio/skills/insects/bee.mp3'
        },
        {
          'path': 'assets/images/skills/insects/ant.jpg',
          'audio': 'assets/audio/skills/insects/ant.mp3'
        },
        {
          'path': 'assets/images/skills/insects/beetle.jpg',
          'audio': 'assets/audio/skills/insects/beetle.mp3'
        },
        {
          'path': 'assets/images/skills/insects/butterfly.jpg',
          'audio': 'assets/audio/skills/insects/butterfly.mp3'
        },
        {
          'path': 'assets/images/skills/insects/cockroach.jpg',
          'audio': 'assets/audio/skills/insects/cockroach.mp3'
        },
        {
          'path': 'assets/images/skills/insects/fly.jpg',
          'audio': 'assets/audio/skills/insects/fly.mp3'
        },
        {
          'path': 'assets/images/skills/insects/locust.jpg',
          'audio': 'assets/audio/skills/insects/locust.mp3'
        },
        {
          'path': 'assets/images/skills/insects/wasp.jpg',
          'audio': 'assets/audio/skills/insects/wasp.mp3'
        },
        {
          'path': 'assets/images/skills/insects/mosquito.jpg',
          'audio': 'assets/audio/skills/insects/mosquito.mp3'
        },
      ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('حشرات'),
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
