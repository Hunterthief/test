import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../theme.dart';

class MinimalPairsGame extends StatefulWidget {
  const MinimalPairsGame({super.key});

  @override
  State<MinimalPairsGame> createState() => _MinimalPairsGameState();
}

class _MinimalPairsGameState extends State<MinimalPairsGame> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<Map<String, dynamic>> _pairs = [
    {
      'sound1': 'س',
      'sound2': 'ص',
      'word1': 'سيف',
      'word2': 'صيف',
      'audio1': 'assets/audio/minimal_pairs/saif.mp3',
      'audio2': 'assets/audio/minimal_pairs/saif_sad.mp3',
      'mouthPosition1': 'assets/images/mouth/sin.png',
      'mouthPosition2': 'assets/images/mouth/sad.png',
    },
    {
      'sound1': 'ت',
      'sound2': 'ط',
      'word1': 'تاج',
      'word2': 'طاج',
      'audio1': 'assets/audio/minimal_pairs/taj.mp3',
      'audio2': 'assets/audio/minimal_pairs/taj_tah.mp3',
      'mouthPosition1': 'assets/images/mouth/ta.png',
      'mouthPosition2': 'assets/images/mouth/tah.png',
    },
  ];

  int _currentPair = 0;
  int _correctAnswers = 0;
  bool _showAnswer = false;
  String? _selectedWord;

  Future<void> _playSound(String path) async {
    try {
      await _audioPlayer.setAsset(path);
      await _audioPlayer.play();
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  void _checkAnswer(String word) {
    setState(() {
      _selectedWord = word;
      _showAnswer = true;
    });

    final current = _pairs[_currentPair];
    bool isCorrect =
        (word == current['word1'] && current['word1'] != current['word2']) ||
            (word == current['word2'] && current['word1'] != current['word2']);

    if (isCorrect) {
      _playSound('assets/audio/SFXs/success.mp3');
      setState(() => _correctAnswers++);
    } else {
      _playSound('assets/audio/SFXs/fail.mp3');
    }

    Future.delayed(Duration(seconds: 3), _nextPair);
  }

  void _nextPair() {
    if (_currentPair < _pairs.length - 1) {
      setState(() {
        _currentPair++;
        _showAnswer = false;
        _selectedWord = null;
      });
    } else {
      _showResults();
    }
  }

  void _showResults() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('النتيجة النهائية'),
        content:
            Text('أجبت بشكل صحيح على $_correctAnswers من ${_pairs.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentPair = 0;
                _correctAnswers = 0;
                _showAnswer = false;
                _selectedWord = null;
              });
            },
            child: Text('إعادة المحاولة'),
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
    final current = _pairs[_currentPair];
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title:
            Text('كشف الأزواج - ${current['sound1']} vs ${current['sound2']}'),
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
                // Mouth position guides
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          current['mouthPosition1'],
                          width: 100,
                          errorBuilder: (_, __, ___) =>
                              Icon(Icons.face, size: 80),
                        ),
                        Text(current['sound1'],
                            style: theme.textTheme.displayLarge),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          current['mouthPosition2'],
                          width: 100,
                          errorBuilder: (_, __, ___) =>
                              Icon(Icons.face, size: 80),
                        ),
                        Text(current['sound2'],
                            style: theme.textTheme.displayLarge),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30),
                // Audio buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _playSound(current['audio1']),
                      child: Text('اسمع الكلمة ١'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () => _playSound(current['audio2']),
                      child: Text('اسمع الكلمة ٢'),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                // Answer options
                Text(
                  'ما هي الكلمة التي سمعتها؟',
                  style:
                      theme.textTheme.labelLarge?.copyWith(color: Colors.white),
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    _buildAnswerOption(current['word1'], current, theme),
                    SizedBox(height: 10),
                    _buildAnswerOption(current['word2'], current, theme),
                  ],
                ),
                SizedBox(height: 30),
                // Progress
                LinearProgressIndicator(
                  value: (_currentPair + 1) / _pairs.length,
                  backgroundColor: Colors.grey,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnswerOption(
      String word, Map<String, dynamic> current, ThemeData theme) {
    bool isCorrectAnswer =
        (word == current['word1'] && current['word1'] != current['word2']) ||
            (word == current['word2'] && current['word1'] != current['word2']);
    bool isSelected = _selectedWord == word;
    Color? bgColor;

    if (_showAnswer) {
      bgColor = isCorrectAnswer
          ? Colors.green
          : isSelected
              ? Colors.red
              : null;
    }

    return SizedBox(
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
        onPressed: _showAnswer ? null : () => _checkAnswer(word),
        child: Text(
          word,
          style: theme.textTheme.labelLarge,
        ),
      ),
    );
  }
}
