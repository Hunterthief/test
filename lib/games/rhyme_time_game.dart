import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../theme.dart';

class RhymeTimeGame extends StatefulWidget {
  const RhymeTimeGame({super.key});

  @override
  State<RhymeTimeGame> createState() => _RhymeTimeGameState();
}

class _RhymeTimeGameState extends State<RhymeTimeGame> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<Map<String, dynamic>> _rhymePairs = <Map<String, dynamic>>[
    {
      'baseWord': 'كتاب',
      'baseAudio': 'assets/audio/rhymes/book.mp3',
      'correctRhyme': 'حساب',
      'options': <String>['قلم', 'حساب', 'مدرسة', 'كرسي'],
    },
    {
      'baseWord': 'شمس',
      'baseAudio': 'assets/audio/rhymes/sun.mp3',
      'correctRhyme': 'قمر',
      'options': <String>['باب', 'قمر', 'سفينة', 'شجرة'],
    },
  ];

  int _currentRound = 0;
  int _score = 0;
  String? _selectedWord;
  bool _showFeedback = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkAssets();
  }

  Future<void> _checkAssets() async {
    try {
      // Check if first audio file exists
      await _audioPlayer.setAsset(_rhymePairs.first['baseAudio']);
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

  void _checkAnswer(String word) {
    setState(() {
      _selectedWord = word;
      _showFeedback = true;
    });

    if (word == _rhymePairs[_currentRound]['correctRhyme']) {
      _playSound('assets/audio/SFXs/success.mp3');
      setState(() => _score++);
    } else {
      _playSound('assets/audio/SFXs/fail.mp3');
    }

    Future.delayed(const Duration(seconds: 2), () {
      if (_currentRound < _rhymePairs.length - 1) {
        setState(() {
          _currentRound++;
          _selectedWord = null;
          _showFeedback = false;
        });
      } else {
        _showFinalScore();
      }
    });
  }

  void _showFinalScore() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('انتهت اللعبة!'),
        content: Text('نقاطك: $_score من ${_rhymePairs.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentRound = 0;
                _score = 0;
                _selectedWord = null;
                _showFeedback = false;
              });
            },
            child: const Text('إعادة'),
          ),
        ],
      ),
    );
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

    final current = _rhymePairs[_currentRound];
    final theme = Theme.of(context);
    final options = (current['options'] as List<String>);

    return Scaffold(
      appBar: AppBar(
        title: const Text('وقت القافية'),
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
                // Base word
                ElevatedButton(
                  onPressed: () => _playSound(current['baseAudio']),
                  child: Text(
                    'اسمع: ${current['baseWord']}',
                    style: theme.textTheme.labelLarge,
                  ),
                ),
                const SizedBox(height: 30),
                // Instruction
                Text(
                  'اختر الكلمة التي تتناغم مع ${current['baseWord']}',
                  style:
                      theme.textTheme.labelLarge?.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                // Options grid
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: options.map((word) {
                    bool isCorrect = word == current['correctRhyme'];
                    bool isSelected = _selectedWord == word;
                    Color? bgColor;

                    if (_showFeedback) {
                      bgColor = isCorrect
                          ? Colors.green
                          : isSelected
                              ? Colors.red
                              : null;
                    }

                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: bgColor,
                      ),
                      onPressed:
                          _showFeedback ? null : () => _checkAnswer(word),
                      child: Text(
                        word,
                        style: theme.textTheme.labelLarge,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                // Score
                Text(
                  'النقاط: $_score',
                  style:
                      theme.textTheme.labelLarge?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
