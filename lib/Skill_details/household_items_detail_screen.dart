import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../theme.dart'; // Import the theme file

class HouseholdItemsDetailScreen extends StatefulWidget {
  @override
  _HouseholdItemsDetailScreenState createState() =>
      _HouseholdItemsDetailScreenState();
}

class _HouseholdItemsDetailScreenState
    extends State<HouseholdItemsDetailScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  List<Map<String, String>> get images => [
        {
          'path': 'assets/images/skills/household_items/clock.jpg',
          'audio': 'assets/audio/skills/household_items/clock.mp3'
        },
        {
          'path': 'assets/images/skills/household_items/vacuum_cleaner.jpg',
          'audio': 'assets/audio/skills/household_items/vacuum_cleaner.mp3'
        },
        {
          'path': 'assets/images/skills/household_items/cooker.jpg',
          'audio': 'assets/audio/skills/household_items/cooker.mp3'
        },
        {
          'path': 'assets/images/skills/household_items/phone.jpg',
          'audio': 'assets/audio/skills/household_items/phone.mp3'
        },
        {
          'path': 'assets/images/skills/household_items/tv.jpg',
          'audio': 'assets/audio/skills/household_items/tv.mp3'
        },
        {
          'path': 'assets/images/skills/household_items/table.jpg',
          'audio': 'assets/audio/skills/household_items/table.mp3'
        },
        {
          'path': 'assets/images/skills/kitchen_utensils/mixer.jpg',
          'audio': 'assets/audio/skillshousehold_items/spoon.mp3'
        },
        {
          'path': 'assets/images/skills/kitchen_utensils/fridge.jpg',
          'audio': 'assets/audio/skills/household_items/fridge.mp3'
        },
        {
          'path': 'assets/images/skills/kitchen_utensils/kitchen_tools.jpg',
          'audio': 'assets/audio/skills/household_items/kitchen_tools.mp3'
        },
        {
          'path': 'assets/images/skills/household_items/mirror.jpg',
          'audio': 'assets/audio/skills/household_items/mirror.mp3'
        },
        {
          'path': 'assets/images/skills/household_items/dresser.jpg',
          'audio': 'assets/audio/skills/household_items/dresser.mp3'
        },
        {
          'path': 'assets/images/skills/household_items/drapes.jpg',
          'audio': 'assets/audio/skills/household_items/drapes.mp3'
        },
        {
          'path': 'assets/images/skills/household_items/door.jpg',
          'audio': 'assets/audio/skills/household_items/door.mp3'
        },
        {
          'path': 'assets/images/skills/household_items/couch.jpg',
          'audio': 'assets/audio/skills/household_items/couch.mp3'
        },
        {
          'path': 'assets/images/skills/household_items/bed.jpg',
          'audio': 'assets/audio/skills/household_items/bed.mp3'
        },
        {
          'path': 'assets/images/skills/household_items/window.jpg',
          'audio': 'assets/audio/skills/household_items/window.mp3'
        },
        {
          'path': 'assets/images/skills/household_items/iron.jpg',
          'audio': 'assets/audio/skills/household_items/iron.mp3'
        },
        {
          'path': 'assets/images/skills/household_items/computor.jpg',
          'audio': 'assets/audio/skills/household_items/computor.mp3'
        },
        {
          'path': 'assets/images/skills/household_items/carpet.jpg',
          'audio': 'assets/audio/skills/household_items/carpet.mp3'
        },
        {
          'path': 'assets/images/skills/household_items/chair.jpg',
          'audio': 'assets/audio/skills/household_items/chair.mp3'
        },
      ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('أدوات منزل'),
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
