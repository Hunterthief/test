import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../theme.dart';

class TongueTwisterGame extends StatefulWidget {
  const TongueTwisterGame({super.key});

  @override
  State<TongueTwisterGame> createState() => _TongueTwisterGameState();
}

class _TongueTwisterGameState extends State<TongueTwisterGame> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<Map<String, dynamic>> _twisters = [
    {
      'text': 'صديقي الصادق صدقني',
      'audio': 'assets/audio/twisters/sadiqi.mp3',
      'level': 1,
      'hint': 'كررها 3 مرات بسرعة!'
    },
    {
      'text': 'خيط حرير على حيط خليل',
      'audio': 'assets/audio/twisters/khit.mp3',
      'level': 2,
      'hint': 'قلها دون أخطاء'
    },
    {
      'text': 'نحن نحب النحل النحيل',
      'audio': 'assets/audio/twisters/nahl.mp3',
      'level': 3,
      'hint': 'أسرع ما يمكن!'
    }
  ];

  int _currentIndex = 0;
  int _attempts = 0;
  bool _isPlaying = false;
  bool _showHint = false;

  Future<void> _playAudio() async {
    try {
      setState(() => _isPlaying = true);
      await _audioPlayer.setAsset(_twisters[_currentIndex]['audio']);
      await _audioPlayer.play();
      setState(() => _isPlaying = false);
    } catch (e) {
      print('Error playing audio: $e');
      setState(() => _isPlaying = false);
    }
  }

  void _nextTwister() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _twisters.length;
      _attempts = 0;
      _showHint = false;
    });
  }

  void _recordAttempt() {
    setState(() {
      _attempts++;
      if (_attempts >= 3) _showHint = true;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final current = _twisters[_currentIndex];
    final theme = Theme.of(context);
    final bool isLastLevel = _currentIndex == _twisters.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('تحديد اللسان - المستوى ${current['level']}'),
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
                // Twister Text
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    current['text'],
                    style: theme.textTheme.displayLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 28,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 30),

                // Hint (appears after 3 attempts)
                if (_showHint)
                  Text(
                    'تلميح: ${current['hint']}',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: Colors.amber,
                    ),
                  ),
                SizedBox(height: 20),

                // Attempt Counter
                Text(
                  'المحاولات: $_attempts',
                  style: theme.textTheme.labelLarge,
                ),
                SizedBox(height: 30),

                // Control Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _isPlaying ? null : _playAudio,
                      child: Text('اسمع النموذج'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _recordAttempt,
                      child: Text('سجل محاولتك'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _nextTwister,
                  child:
                      Text(isLastLevel ? 'إعادة من البداية' : 'التحدي التالي'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
