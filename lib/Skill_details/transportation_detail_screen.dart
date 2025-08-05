import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../theme.dart'; // Import the theme file

class TransportationDetailScreen extends StatefulWidget {
  @override
  _TransportationDetailScreenState createState() =>
      _TransportationDetailScreenState();
}

class _TransportationDetailScreenState
    extends State<TransportationDetailScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  List<Map<String, String>> get images => [
        {
          'path': 'assets/images/skills/transportation/motorcycle.jpg',
          'audio': 'assets/audio/skills/transportation/motorcycle.mp3'
        },
        {
          'path': 'assets/images/skills/transportation/car.jpg',
          'audio': 'assets/audio/skills/transportation/car.mp3'
        },
        {
          'path': 'assets/images/skills/transportation/bike.jpg',
          'audio': 'assets/audio/skills/transportation/bike.mp3'
        },
        {
          'path': 'assets/images/skills/transportation/police_car.jpg',
          'audio': 'assets/audio/skills/transportation/police_car.mp3'
        },
        {
          'path': 'assets/images/skills/transportation/plane.jpg',
          'audio': 'assets/audio/skills/transportation/plane.mp3'
        },
        {
          'path': 'assets/images/skills/transportation/boat.jpg',
          'audio': 'assets/audio/skills/transportation/boat.mp3'
        },
        {
          'path': 'assets/images/skills/transportation/fire_truck.jpg',
          'audio': 'assets/audio/skills/transportation/fire_truck.mp3'
        },
        {
          'path': 'assets/images/skills/transportation/ambulance.jpg',
          'audio': 'assets/audio/skills/transportation/ambulance.mp3'
        },
        {
          'path': 'assets/images/skills/transportation/bus.jpg',
          'audio': 'assets/audio/skills/transportation/bus.mp3'
        },
        {
          'path': 'assets/images/skills/transportation/air_ballon.jpg',
          'audio': 'assets/audio/skills/transportation/air_ballon.mp3'
        },
        {
          'path': 'assets/images/skills/transportation/rocket.jpg',
          'audio': 'assets/audio/skills/transportation/rocket.mp3'
        },
        {
          'path': 'assets/images/skills/transportation/train.jpg',
          'audio': 'assets/audio/skills/transportation/train.mp3'
        },
        {
          'path': 'assets/images/skills/transportation/truck.jpg',
          'audio': 'assets/audio/skills/transportation/truck.mp3'
        },
        {
          'path': 'assets/images/skills/transportation/helecopter.jpg',
          'audio': 'assets/audio/skills/transportation/helecopter.mp3'
        },
      ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('المواصلات'),
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
