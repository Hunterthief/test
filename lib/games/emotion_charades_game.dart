import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../theme.dart';

class EmotionCharadesGame extends StatefulWidget {
  const EmotionCharadesGame({super.key});

  @override
  State<EmotionCharadesGame> createState() => _EmotionCharadesGameState();
}

class _EmotionCharadesGameState extends State<EmotionCharadesGame> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<Map<String, dynamic>> _emotions = [
    {
      'name': 'سعيد',
      'image': 'assets/images/emotions/happy.png',
      'audio': 'assets/audio/emotions/happy.mp3',
      'prompt': 'متى تشعر بهذا الشعور؟',
      'scenarios': ['عندما ألعب مع أصدقائي', 'عندما أحصل على هدية']
    },
    {
      'name': 'حزين',
      'image': 'assets/images/emotions/sad.png',
      'audio': 'assets/audio/emotions/sad.mp3',
      'prompt': 'ماذا تفعل عندما تشعر هكذا؟',
      'scenarios': ['عندما يكسر لعبتي', 'عندما يمرض صديقي']
    },
    {
      'name': 'غاضب',
      'image': 'assets/images/emotions/angry.png',
      'audio': 'assets/audio/emotions/angry.mp3',
      'prompt': 'كيف تهدئ نفسك؟',
      'scenarios': ['عندما يأخذ أخي لعبتي', 'عندما لا أستطيع فعل شيء']
    }
  ];

  int _currentIndex = 0;
  bool _isPlaying = false;
  bool _showScenario = false;
  int _selectedScenario = -1;

  Future<void> _playEmotionSound() async {
    try {
      setState(() => _isPlaying = true);
      await _audioPlayer.setAsset(_emotions[_currentIndex]['audio']);
      await _audioPlayer.play();
      setState(() => _isPlaying = false);
    } catch (e) {
      print('Error playing sound: $e');
      setState(() => _isPlaying = false);
    }
  }

  void _nextEmotion() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _emotions.length;
      _showScenario = false;
      _selectedScenario = -1;
    });
  }

  void _toggleScenario() {
    setState(() => _showScenario = !_showScenario);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final current = _emotions[_currentIndex];
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('تمثيل المشاعر'),
        backgroundColor: theme.customThemeData.darkPrimaryGradient.colors.first,
        actions: [
          IconButton(
            icon: Icon(Icons.volume_up),
            onPressed: _isPlaying ? null : _playEmotionSound,
          )
        ],
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
                // Emotion Display
                Column(
                  children: [
                    Image.asset(
                      current['image'],
                      width: 150,
                      height: 150,
                      errorBuilder: (_, __, ___) => Icon(Icons.face, size: 100),
                    ),
                    SizedBox(height: 20),
                    Text(
                      current['name'],
                      style: theme.textTheme.displayLarge?.copyWith(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),

                // Scenario Prompt
                Text(
                  current['prompt'],
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),

                // Scenario Toggle
                ElevatedButton(
                  onPressed: _toggleScenario,
                  child: Text(_showScenario ? 'إخفاء المواقف' : 'عرض مواقف'),
                ),
                SizedBox(height: 20),

                // Scenario Options
                if (_showScenario)
                  Column(
                    children: [
                      ...List.generate(current['scenarios'].length, (index) {
                        return RadioListTile<int>(
                          title: Text(
                            current['scenarios'][index],
                            style: theme.textTheme.labelLarge,
                          ),
                          value: index,
                          groupValue: _selectedScenario,
                          onChanged: (value) {
                            setState(() => _selectedScenario = value!);
                          },
                        );
                      }),
                      SizedBox(height: 20),
                      if (_selectedScenario >= 0)
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('إجابة رائعة!'),
                                content: Text('يمكنك تمثيل هذا الموقف الآن'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('حسنًا'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Text('شارك إجابتك'),
                        ),
                    ],
                  ),

                // Navigation
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _nextEmotion,
                  child: Text('التالي'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
