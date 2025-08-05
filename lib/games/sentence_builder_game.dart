import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../theme.dart';

class SentenceBuilderGame extends StatefulWidget {
  const SentenceBuilderGame({super.key});

  @override
  State<SentenceBuilderGame> createState() => _SentenceBuilderGameState();
}

class _SentenceBuilderGameState extends State<SentenceBuilderGame> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<Map<String, dynamic>> _levels = <Map<String, dynamic>>[
    {
      'target': 'الولد يأكل تفاحة',
      'words': <String>['الولد', 'يأكل', 'تفاحة'],
      'audio': 'assets/audio/sentences/boy_eat_apple.mp3',
      'image': 'assets/images/sentences/level_0.png',
    },
    {
      'target': 'القطة تشرب حليب',
      'words': <String>['القطة', 'تشرب', 'حليب'],
      'audio': 'assets/audio/sentences/cat_drink_milk.mp3',
      'image': 'assets/images/sentences/level_1.png',
    },
  ];

  int _currentLevel = 0;
  final List<String> _selectedWords = [];
  bool _isCorrect = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkAssets();
  }

  Future<void> _checkAssets() async {
    try {
      // Check if audio files exist
      await _audioPlayer.setAsset(_levels[_currentLevel]['audio']);
      setState(() => _isLoading = false);
    } catch (e) {
      setState(() => _isLoading = false);
      debugPrint('Error loading assets: $e');
    }
  }

  Future<void> _playSound(String path) async {
    try {
      await _audioPlayer.setAsset(path);
      await _audioPlayer.play();
    } catch (e) {
      debugPrint('Error playing sound: $e');
    }
  }

  void _checkSentence() {
    final userSentence = _selectedWords.join(' ');
    if (userSentence == _levels[_currentLevel]['target']) {
      setState(() => _isCorrect = true);
      _playSound('assets/audio/SFXs/success.mp3');
      _playSound(_levels[_currentLevel]['audio']);
    } else {
      _playSound('assets/audio/SFXs/fail.mp3');
    }
  }

  void _nextLevel() {
    setState(() {
      _currentLevel = (_currentLevel + 1) % _levels.length;
      _selectedWords.clear();
      _isCorrect = false;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final current = _levels[_currentLevel];
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('بناء الجمل - المستوى ${_currentLevel + 1}'),
        backgroundColor: theme.customThemeData.darkPrimaryGradient.colors.first,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: theme.brightness == Brightness.dark
              ? theme.customThemeData.darkPrimaryGradient
              : theme.customThemeData.lightPrimaryGradient,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Target image
                Image.asset(
                  current['image'],
                  width: 150,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.image, size: 100),
                ),
                const SizedBox(height: 30),

                // Selected words
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      _selectedWords.join(' '),
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Word bank
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: (current['words'] as List<String>).map((word) {
                    return Draggable<String>(
                      data: word,
                      feedback: Material(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            word,
                            style: theme.textTheme.labelLarge,
                          ),
                        ),
                      ),
                      childWhenDragging: Opacity(
                        opacity: 0.5,
                        child: Text(word),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() => _selectedWords.add(word));
                        },
                        child: Text(word),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 30),

                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _checkSentence,
                      child: const Text('تحقق'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _nextLevel,
                      child: const Text('التالي'),
                    ),
                  ],
                ),
                if (_isCorrect)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'أحسنت!',
                      style: theme.textTheme.displayLarge?.copyWith(
                        color: Colors.green,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
