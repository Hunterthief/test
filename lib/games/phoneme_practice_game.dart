import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../theme.dart';

class PhonemePracticeGame extends StatefulWidget {
  const PhonemePracticeGame({super.key});

  @override
  State<PhonemePracticeGame> createState() => _PhonemePracticeGameState();
}

class _PhonemePracticeGameState extends State<PhonemePracticeGame> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<Map<String, dynamic>> _phonemes = [
    {'sound': 'ر', 'image': 'assets/images/phonemes/ra.png', 'word': 'أسد'},
    {'sound': 'س', 'image': 'assets/images/phonemes/sin.png', 'word': 'شمس'},
    {'sound': 'ش', 'image': 'assets/images/phonemes/shin.png', 'word': 'قلم'},
  ];
  int _currentIndex = 0;
  int _stars = 0;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playSound(String sound) async {
    try {
      await _audioPlayer.setAsset('assets/audio/phonemes/$sound.mp3');
      await _audioPlayer.play();
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  void _nextPhoneme() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _phonemes.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final current = _phonemes[_currentIndex];
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('تمرين الأصوات - ${current['sound']}'),
        backgroundColor: theme.customThemeData.darkPrimaryGradient.colors.first,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: theme.brightness == Brightness.dark
              ? theme.customThemeData.darkPrimaryGradient
              : theme.customThemeData.lightPrimaryGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image with sound
              GestureDetector(
                onTap: () => _playSound(current['sound']),
                child: Image.asset(
                  current['image'],
                  width: 200,
                  errorBuilder: (_, __, ___) =>
                      Icon(Icons.volume_up, size: 100),
                ),
              ),
              SizedBox(height: 20),
              // Word example
              Text(
                'مثال: ${current['word']}',
                style:
                    theme.textTheme.labelLarge?.copyWith(color: Colors.white),
              ),
              SizedBox(height: 30),
              // Star rating
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    3,
                    (index) => Icon(
                          index < _stars ? Icons.star : Icons.star_border,
                          color: Colors.yellow,
                          size: 40,
                        )),
              ),
              SizedBox(height: 20),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _playSound(current['sound']),
                    child: Text('كرر الصوت'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() => _stars = (_stars + 1) % 4);
                      _nextPhoneme();
                    },
                    child: Text('حاول بنفسك'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
