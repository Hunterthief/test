import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../theme.dart';

class StorytellingGame extends StatefulWidget {
  const StorytellingGame({super.key});

  @override
  State<StorytellingGame> createState() => _StorytellingGameState();
}

class _StorytellingGameState extends State<StorytellingGame> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<Map<String, dynamic>> _stories = [
    {
      'title': 'في المزرعة',
      'background': 'assets/images/stories/farm.png',
      'elements': [
        {'image': 'assets/images/stories/cow.png', 'word': 'بقرة'},
        {'image': 'assets/images/stories/barn.png', 'word': 'حظيرة'},
        {'image': 'assets/images/stories/sun.png', 'word': 'شمس'},
      ],
      'prompts': ['ذهب الولد إلى ___', 'رأى ___', 'كان الجو ___'],
      'narrations': [
        'assets/audio/stories/farm_part1.mp3',
        'assets/audio/stories/farm_part2.mp3',
      ]
    }
  ];

  int _currentStory = 0;
  int _currentPart = 0;
  List<String> _selectedWords = [];
  bool _isPlayingAudio = false;

  Future<void> _playSound(String path) async {
    try {
      setState(() => _isPlayingAudio = true);
      await _audioPlayer.setAsset(path);
      await _audioPlayer.play();
      setState(() => _isPlayingAudio = false);
    } catch (e) {
      print('Error playing sound: $e');
      setState(() => _isPlayingAudio = false);
    }
  }

  void _addWord(String word) {
    setState(() {
      _selectedWords.add(word);
      if (_selectedWords.length == _stories[_currentStory]['prompts'].length) {
        _playSound(_stories[_currentStory]['narrations'].last);
      }
    });
  }

  void _resetStory() {
    setState(() {
      _selectedWords = [];
      _currentPart = 0;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentStory = _stories[_currentStory];
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(currentStory['title']),
        backgroundColor: theme.customThemeData.darkPrimaryGradient.colors.first,
        actions: [
          IconButton(
            icon: Icon(Icons.replay),
            onPressed: _resetStory,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: theme.brightness == Brightness.dark
              ? theme.customThemeData.darkPrimaryGradient
              : theme.customThemeData.lightPrimaryGradient,
          image: DecorationImage(
            image: AssetImage(currentStory['background']),
            fit: BoxFit.cover,
            opacity: 0.3,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Story progress
                LinearProgressIndicator(
                  value: (_currentPart + 1) / currentStory['prompts'].length,
                  backgroundColor: Colors.grey,
                  color: Colors.blue,
                ),
                SizedBox(height: 20),

                // Story display area
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Current story part
                      Text(
                        currentStory['prompts'][_currentPart],
                        style: theme.textTheme.displayLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 28,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),

                      // Selected words
                      if (_selectedWords.isNotEmpty)
                        Text(
                          _selectedWords.join(' '),
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Colors.amber,
                            fontSize: 24,
                          ),
                        ),
                    ],
                  ),
                ),

                // Story elements
                SizedBox(
                  height: 120,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: currentStory['elements'].length,
                    separatorBuilder: (_, __) => SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final element = currentStory['elements'][index];
                      return Draggable<String>(
                        data: element['word'],
                        feedback: Material(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  element['image'],
                                  width: 60,
                                  height: 60,
                                  errorBuilder: (_, __, ___) =>
                                      Icon(Icons.image, size: 60),
                                ),
                                Text(element['word']),
                              ],
                            ),
                          ),
                        ),
                        childWhenDragging: Opacity(
                          opacity: 0.5,
                          child: _buildStoryElement(element),
                        ),
                        child: _buildStoryElement(element),
                      );
                    },
                  ),
                ),

                // Narration controls
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isPlayingAudio
                      ? null
                      : () =>
                          _playSound(currentStory['narrations'][_currentPart]),
                  child: Text('اسمع القصة'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStoryElement(Map<String, dynamic> element) {
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return Column(
          children: [
            Image.asset(
              element['image'],
              width: 60,
              height: 60,
              errorBuilder: (_, __, ___) => Icon(Icons.image, size: 60),
            ),
            Text(element['word']),
          ],
        );
      },
      onAccept: (data) {
        if (_currentPart < _stories[_currentStory]['prompts'].length - 1) {
          setState(() => _currentPart++);
        }
        _addWord(data);
      },
    );
  }
}
