import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../theme.dart'; // Assuming theme.dart contains your light and dark mode styles

class ColorsDetailScreen extends StatefulWidget {
  @override
  _ColorsDetailScreenState createState() => _ColorsDetailScreenState();
}

class _ColorsDetailScreenState extends State<ColorsDetailScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  List<Map<String, String>> get colors => [
        {
          'colorName': 'أحمر', // Arabic for "Red"
          'colorCode': 'FF0000',
          'audio': 'assets/audio/skills/colors/red.mp3'
        },
        {
          'colorName': 'أزرق', // Arabic for "Blue"
          'colorCode': '0000FF',
          'audio': 'assets/audio/skills/colors/blue.mp3'
        },
        {
          'colorName': 'أصفر', // Arabic for "Yellow"
          'colorCode': 'FFFF00',
          'audio': 'assets/audio/skills/colors/yellow.mp3'
        },
        {
          'colorName': 'أخضر', // Arabic for "Green"
          'colorCode': '008000',
          'audio': 'assets/audio/skills/colors/green.mp3'
        },
        {
          'colorName': 'أسود', // Arabic for "Black"
          'colorCode': '000000',
          'audio': 'assets/audio/skills/colors/black.mp3'
        },
        {
          'colorName': 'أبيض', // Arabic for "White"
          'colorCode': 'FFFFFF',
          'audio': 'assets/audio/skills/colors/white.mp3'
        },
        {
          'colorName': 'برتقالي', // Arabic for "Orange"
          'colorCode': 'FFA500',
          'audio': 'assets/audio/skills/colors/orange.mp3'
        },
        {
          'colorName': 'رمادي', // Arabic for "Gray"
          'colorCode': '808080',
          'audio': 'assets/audio/skills/colors/gray.mp3'
        },
        {
          'colorName': 'وردي', // Arabic for "Pink"
          'colorCode': 'FFC0CB',
          'audio': 'assets/audio/skills/colors/pink.mp3'
        },
        {
          'colorName': 'بني', // Arabic for "Brown"
          'colorCode': 'A52A2A',
          'audio': 'assets/audio/skills/colors/brown.mp3'
        },
        {
          'colorName': 'بنفسجي', // Arabic for "Purple"
          'colorCode': '800080',
          'audio': 'assets/audio/skills/colors/purple.mp3'
        },
        {
          'colorName': 'سماوي', // Arabic for "Cyan"
          'colorCode': '00FFFF',
          'audio': 'assets/audio/skills/colors/cyan.mp3'
        },
        {
          'colorName': 'أرجواني', // Arabic for "Magenta"
          'colorCode': 'FF00FF',
          'audio': 'assets/audio/skills/colors/magenta.mp3'
        },
        {
          'colorName': 'كحلي', // Arabic for "Navy Blue"
          'colorCode': '000080',
          'audio': 'assets/audio/skills/colors/navy_blue.mp3'
        },
        {
          'colorName': 'أخضر فاتح', // Arabic for "Light Green"
          'colorCode': '90EE90',
          'audio': 'assets/audio/skills/colors/light_green.mp3'
        },
        {
          'colorName': 'أصفر ذهبي', // Arabic for "Golden Yellow"
          'colorCode': 'FFD700',
          'audio': 'assets/audio/skills/colors/golden_yellow.mp3'
        },
        {
          'colorName': 'أخضر زيتوني', // Arabic for "Olive Green"
          'colorCode': '808000',
          'audio': 'assets/audio/skills/colors/olive_green.mp3'
        },
        {
          'colorName': 'أزرق سماوي', // Arabic for "Sky Blue"
          'colorCode': '87CEEB',
          'audio': 'assets/audio/skills/colors/sky_blue.mp3'
        },
        {
          'colorName': 'أحمر داكن', // Arabic for "Dark Red"
          'colorCode': '8B0000',
          'audio': 'assets/audio/skills/colors/dark_red.mp3'
        },
        {
          'colorName': 'أخضر داكن', // Arabic for "Dark Green"
          'colorCode': '006400',
          'audio': 'assets/audio/skills/colors/dark_green.mp3'
        },
        {
          'colorName': 'أزرق غامق', // Arabic for "Deep Blue"
          'colorCode': '0018A8',
          'audio': 'assets/audio/skills/colors/deep_blue.mp3'
        },
        {
          'colorName': 'أزرق ثلجي', // Arabic for "Ice Blue"
          'colorCode': '99FFFF',
          'audio': 'assets/audio/skills/colors/ice_blue.mp3'
        },

        // Add other colors as needed
      ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('الألوان'), // Colors
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
          itemCount: colors.length,
          itemBuilder: (context, index) {
            final color = colors[index];
            final colorCode = color['colorCode']!;
            final isBright =
                _isBrightColor(Color(int.parse('0xFF' + colorCode)));
            final textColor = isBright ? Colors.black : Colors.white;

            return GestureDetector(
              onTap: () {
                _onColorTap(
                    context, colorCode, color['audio']!, color['colorName']!);
              },
              child: Container(
                color: Color(int.parse('0xFF' + colorCode)),
                child: Center(
                  child: Text(
                    color['colorName']!,
                    style: TextStyle(color: textColor, fontSize: 24),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onColorTap(BuildContext context, String colorCode, String audioPath,
      String colorName) async {
    // Attempt to play audio if it exists
    try {
      await _audioPlayer.setAsset(audioPath);
      await _audioPlayer.stop();
      _audioPlayer.play();
    } catch (e) {
      print("Audio file not found: $audioPath"); // Handle missing audio
    }

    // Show the enlarged color in the dialog
    _showColorDetailDialog(context, colorCode, audioPath, colorName);
  }

  void _showColorDetailDialog(BuildContext context, String colorCode,
      String audioPath, String colorName) {
    final isBright = _isBrightColor(Color(int.parse('0xFF' + colorCode)));
    final textColor = isBright ? Colors.black : Colors.white;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Display enlarged color view
            Container(
              width: 300,
              height: 300,
              color: Color(int.parse('0xFF' + colorCode)),
              child: Center(
                child: Text(
                  colorName,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Conditionally show the play button if the audio file exists
            FutureBuilder(
              future: _audioPlayer.setAsset(audioPath),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.error == null) {
                  return ElevatedButton(
                    onPressed: () async {
                      await _audioPlayer.setAsset(audioPath);
                      _audioPlayer.play();
                    },
                    child: Text('تشغيل الصوت'),
                  );
                } else {
                  return SizedBox
                      .shrink(); // Optionally display a message or nothing
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Utility function to determine if a color is bright
  bool _isBrightColor(Color color) {
    final brightness = (color.r * 299 + color.g * 587 + color.b * 114) / 1000;
    return brightness > 128;
  }
}
