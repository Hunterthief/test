// lib/Skill_details/careers_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../theme.dart'; // Import the theme file

class CareersDetailScreen extends StatefulWidget {
  @override
  _CareersDetailScreenState createState() => _CareersDetailScreenState();
}

class _CareersDetailScreenState extends State<CareersDetailScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose of the audio player when done
    super.dispose();
  }

  List<Map<String, String>> get images => [
        {
          'path': 'assets/images/skills/careers/baker.jpg',
          'audio': 'assets/audio/skills/careers/baker.mp3'
        },
        {
          'path': 'assets/images/skills/careers/barber.jpg',
          'audio': 'assets/audio/skills/careers/barber.mp3'
        },
        {
          'path': 'assets/images/skills/careers/butcher.jpg',
          'audio': 'assets/audio/skills/careers/butcher.mp3'
        },
        {
          'path': 'assets/images/skills/careers/carpenter.jpg',
          'audio': 'assets/audio/skills/careers/carpenter.mp3'
        },
        {
          'path': 'assets/images/skills/careers/doctor.jpg',
          'audio': 'assets/audio/skills/careers/doctor.mp3'
        },
        {
          'path': 'assets/images/skills/careers/engineer.jpg',
          'audio': 'assets/audio/skills/careers/engineer.mp3'
        },
        {
          'path': 'assets/images/skills/careers/farmer.jpg',
          'audio': 'assets/audio/skills/careers/farmer.mp3'
        },
        {
          'path': 'assets/images/skills/careers/journalist.jpg',
          'audio': 'assets/audio/skills/careers/journalist.mp3'
        },
        {
          'path': 'assets/images/skills/careers/mechanic.jpg',
          'audio': 'assets/audio/skills/careers/mechanic.mp3'
        },
        {
          'path': 'assets/images/skills/careers/painter_1.jpg',
          'audio': 'assets/audio/skills/careers/painter_1.mp3'
        },
        {
          'path': 'assets/images/skills/careers/painter_2.jpg',
          'audio': 'assets/audio/skills/careers/painter_2.mp3'
        },
        {
          'path': 'assets/images/skills/careers/photographer.jpg',
          'audio': 'assets/audio/skills/careers/photographer.mp3'
        },
        {
          'path': 'assets/images/skills/careers/pilot.jpg',
          'audio': 'assets/audio/skills/careers/pilot.mp3'
        },
        {
          'path': 'assets/images/skills/careers/sailor.jpg',
          'audio': 'assets/audio/skills/careers/sailor.mp3'
        },
        {
          'path': 'assets/images/skills/careers/teacher.jpg',
          'audio': 'assets/audio/skills/careers/teacher.mp3'
        }, // Add more careers as needed
      ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('مهن'),
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
