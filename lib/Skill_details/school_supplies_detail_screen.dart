import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../theme.dart'; // Import the theme file

class SchoolSuppliesDetailScreen extends StatefulWidget {
  @override
  _SchoolSuppliesDetailScreenState createState() =>
      _SchoolSuppliesDetailScreenState();
}

class _SchoolSuppliesDetailScreenState
    extends State<SchoolSuppliesDetailScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  List<Map<String, String>> get images => [
        {
          'path': 'assets/images/skills/school_supplies/pencil.jpg',
          'audio': 'assets/audio/skills/school_supplies/pencil.mp3'
        },
        {
          'path': 'assets/images/skills/school_supplies/chalk.jpg',
          'audio': 'assets/audio/skills/school_supplies/chalk.mp3'
        },
        {
          'path': 'assets/images/skills/school_supplies/eraser.jpg',
          'audio': 'assets/audio/skills/school_supplies/eraser.mp3'
        },
        {
          'path': 'assets/images/skills/school_supplies/ruler.jpg',
          'audio': 'assets/audio/skills/school_supplies/ruler.mp3'
        },
        {
          'path': 'assets/images/skills/school_supplies/sharpener.jpg',
          'audio': 'assets/audio/skills/school_supplies/sharpener.mp3'
        },
        {
          'path': 'assets/images/skills/school_supplies/pen.jpg',
          'audio': 'assets/audio/skills/school_supplies/pen.mp3'
        },
        {
          'path': 'assets/images/skills/school_supplies/cutters.jpg',
          'audio': 'assets/audio/skills/school_supplies/cutters.mp3'
        },
        {
          'path': 'assets/images/skills/school_supplies/ducttape.jpg',
          'audio': 'assets/audio/skills/school_supplies/ducttape.mp3'
        },
        {
          'path': 'assets/images/skills/school_supplies/eraser_2.jpg',
          'audio': 'assets/audio/skills/school_supplies/eraser_2.mp3'
        },
        {
          'path': 'assets/images/skills/school_supplies/marker.jpg',
          'audio': 'assets/audio/skills/school_supplies/marker.mp3'
        },
        {
          'path': 'assets/images/skills/school_supplies/marker_2.jpg',
          'audio': 'assets/audio/skills/school_supplies/marker_2.mp3'
        },
        {
          'path': 'assets/images/skills/school_supplies/water_colors.jpg',
          'audio': 'assets/audio/skills/school_supplies/water_colors.mp3'
        },
        {
          'path': 'assets/images/skills/school_supplies/penclie_case.jpg',
          'audio': 'assets/audio/skills/school_supplies/penclie_case.mp3'
        },
        {
          'path': 'assets/images/skills/school_supplies/colored_pencile.jpg',
          'audio': 'assets/audio/skills/school_supplies/colored_pencile.mp3'
        },
      ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('أدوات مدرسية'),
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
