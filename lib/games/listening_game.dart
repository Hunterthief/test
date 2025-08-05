import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../theme.dart';

class GameLevel {
  final String instruction;
  final dynamic target;
  final List<Map<String, String>> objects;
  final String prompt;
  final String category;

  GameLevel({
    required this.instruction,
    required this.target,
    required this.objects,
    required this.prompt,
    required this.category,
  });
}

class ListeningGame extends StatefulWidget {
  const ListeningGame({super.key});

  @override
  State<ListeningGame> createState() => _ListeningGameState();
}

class _ListeningGameState extends State<ListeningGame> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  late List<GameLevel> _levels;
  late List<GameLevel> _availableLevels;
  final Random _random = Random();
  int _currentLevel = 0;
  List<String> _selectedSequence = [];
  bool _isPlaying = false;
  bool _showError = false;
  bool _isDisposed = false;
  bool _isLoading = true;
  final Set<String> _usedCategories = {};

  // Categories and their manifest paths
  final Map<String, String> _categoryManifests = {
    'animals': 'assets/images/skills/animals/manifest.json',
    'fruits': 'assets/images/skills/fruits/manifest.json',
    'vegetables': 'assets/images/skills/vegetables/manifest.json',
    'colors': 'assets/images/skills/colors/manifest.json',
    'careers': 'assets/images/skills/careers/manifest.json',
    'clothing': 'assets/images/skills/clothing/manifest.json',
    'transportation': 'assets/images/skills/transportation/manifest.json',
    'insects': 'assets/images/skills/insects/manifest.json',
    'kitchen utensils': 'assets/images/skills/kitchen_utensils/manifest.json',
    'school supplies': 'assets/images/skills/school_supplies/manifest.json',
    'household items': 'assets/images/skills/household_items/manifest.json',
  };

  // Arabic names mapping
  final Map<String, String> _arabicNames = {
    'cat': 'قطة',
    'dog': 'كلب',
    'lion': 'أسد',
    'tiger': 'نمر',
    'elephant': 'فيل',
    'bird': 'عصفور',
    'fish': 'سمكة',
    'apple': 'تفاحة',
    'banana': 'موزة',
    'orange': 'برتقالة',
    'grape': 'عنب',
    'watermelon': 'بطيخ',
    'carrot': 'جزر',
    'tomato': 'طماطم',
    'cucumber': 'خيار',
    'red': 'أحمر',
    'yellow': 'أصفر',
    'green': 'أخضر',
    'bear': 'دب',
    'camel': 'جمل',
    'chicken': 'دجاجة',
    'cow': 'بقرة',
    'deer': 'غزال',
    'fox': 'ثعلب',
    'frog': 'ضفدع',
    'horse': 'حصان',
    'monkey': 'قرد',
    'rabbit': 'أرنب',
    'sheep': 'خروف',
    'wolf': 'ذئب',
    'zebra': 'حمار وحشي',
    'ant': 'نملة',
    'bee': 'نحلة',
    'butterfly': 'فراشة',
    'doctor': 'طبيب',
    'teacher': 'معلم',
    'engineer': 'مهندس',
    'shirt': 'قميص',
    'pants': 'بنطال',
    'hat': 'قبعة',
  };

  @override
  void initState() {
    super.initState();
    _loadLevels();
  }

  Future<void> _loadLevels() async {
    try {
      // Load all manifests
      final Map<String, List<Map<String, String>>> imageCategories = {};

      for (final category in _categoryManifests.keys) {
        final manifestPath = _categoryManifests[category]!;
        final manifestContent = await rootBundle.loadString(manifestPath);
        final manifestJson =
            json.decode(manifestContent) as Map<String, dynamic>;

        final imagesList = manifestJson['images'] as List;
        final images = imagesList.map((image) {
          final imageName = image as String;
          return {
            'name': imageName.split('.')[0],
            'image': 'assets/images/skills/$category/$imageName'
          };
        }).toList();

        imageCategories[category] = images;
      }

      // Generate all possible levels
      final allLevels = _generateAllPossibleLevels(imageCategories);

      setState(() {
        _availableLevels = List.from(allLevels);
        _levels = _selectLevelsWithProgression(15);
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading manifests: $e');
      setState(() {
        _levels = _createDefaultLevels();
        _isLoading = false;
      });
    }
  }

  List<GameLevel> _generateAllPossibleLevels(
      Map<String, List<Map<String, String>>> imageCategories) {
    final levels = <GameLevel>[];
    final instructionPrefix = 'assets/audio/instructions/';

    for (final category in imageCategories.keys) {
      final categoryItems = imageCategories[category]!;

      // Generate single-target levels
      for (final item in categoryItems) {
        final otherItems = categoryItems.where((i) => i != item).toList();
        if (otherItems.isNotEmpty) {
          final objects = [
            item,
            otherItems[_random.nextInt(otherItems.length)]
          ];
          levels.add(GameLevel(
            instruction: '${instructionPrefix}single_target.mp3',
            target: item['name']!,
            objects: objects,
            prompt: 'المس ${_getArabicName(item['name']!)}',
            category: category,
          ));
        }
      }

      // Generate two-step levels (if enough items)
      if (categoryItems.length >= 3) {
        for (int i = 0; i < min(5, categoryItems.length); i++) {
          final shuffled = List<Map<String, String>>.from(categoryItems)
            ..shuffle(_random);
          final targetSequence =
              shuffled.take(2).map((e) => e['name']!).toList();
          levels.add(GameLevel(
            instruction: '${instructionPrefix}two_steps.mp3',
            target: targetSequence,
            objects: shuffled.take(3).toList(),
            prompt:
                'المس ${_getArabicName(targetSequence[0])} ثم ${_getArabicName(targetSequence[1])}',
            category: category,
          ));
        }
      }

      // Generate three-step levels (if enough items)
      if (categoryItems.length >= 4) {
        for (int i = 0; i < min(3, categoryItems.length); i++) {
          final shuffled = List<Map<String, String>>.from(categoryItems)
            ..shuffle(_random);
          final targetSequence =
              shuffled.take(3).map((e) => e['name']!).toList();
          levels.add(GameLevel(
            instruction: '${instructionPrefix}three_steps.mp3',
            target: targetSequence,
            objects: shuffled.take(4).toList(),
            prompt:
                'المس ${_getArabicName(targetSequence[0])} ثم ${_getArabicName(targetSequence[1])} ثم ${_getArabicName(targetSequence[2])}',
            category: category,
          ));
        }
      }
    }

    return levels;
  }

  List<GameLevel> _selectLevelsWithProgression(int count) {
    final selectedLevels = <GameLevel>[];
    final available = List<GameLevel>.from(_availableLevels);

    // First select 5 single-target levels
    final singleTargetLevels =
        available.where((level) => level.target is String).toList();
    selectedLevels.addAll(singleTargetLevels.take(5));

    // Then select 5 two-step levels
    final twoStepLevels = available
        .where((level) =>
            level.target is List<String> &&
            (level.target as List<String>).length == 2)
        .toList();
    selectedLevels.addAll(twoStepLevels.take(5));

    // Finally select 5 three-step levels
    final threeStepLevels = available
        .where((level) =>
            level.target is List<String> &&
            (level.target as List<String>).length == 3)
        .toList();
    selectedLevels.addAll(threeStepLevels.take(5));

    // Shuffle within each difficulty group to maintain progression but add variety
    selectedLevels.shuffle(_random);

    return selectedLevels.take(count).toList();
  }

  List<GameLevel> _createDefaultLevels() {
    return [
      // Single-target levels
      GameLevel(
        instruction: 'assets/audio/instructions/single_target.mp3',
        target: 'cat',
        objects: [
          {'name': 'cat', 'image': 'assets/images/skills/animals/cat.jpg'},
          {'name': 'dog', 'image': 'assets/images/skills/animals/dog.jpeg'},
        ],
        prompt: 'المس القطة',
        category: 'animals',
      ),
      GameLevel(
        instruction: 'assets/audio/instructions/single_target.mp3',
        target: 'apple',
        objects: [
          {'name': 'apple', 'image': 'assets/images/skills/fruits/apple.jpg'},
          {'name': 'banana', 'image': 'assets/images/skills/fruits/banana.jpg'},
        ],
        prompt: 'المس التفاحة',
        category: 'fruits',
      ),
      // Two-step levels
      GameLevel(
        instruction: 'assets/audio/instructions/two_steps.mp3',
        target: ['cat', 'dog'],
        objects: [
          {'name': 'cat', 'image': 'assets/images/skills/animals/cat.jpg'},
          {'name': 'dog', 'image': 'assets/images/skills/animals/dog.jpeg'},
          {'name': 'lion', 'image': 'assets/images/skills/animals/lion.jpg'},
        ],
        prompt: 'المس القطة ثم الكلب',
        category: 'animals',
      ),
      // Three-step levels
      GameLevel(
        instruction: 'assets/audio/instructions/three_steps.mp3',
        target: ['apple', 'banana', 'orange'],
        objects: [
          {'name': 'apple', 'image': 'assets/images/skills/fruits/apple.jpg'},
          {'name': 'banana', 'image': 'assets/images/skills/fruits/banana.jpg'},
          {'name': 'orange', 'image': 'assets/images/skills/fruits/orange.jpg'},
          {'name': 'grape', 'image': 'assets/images/skills/fruits/grapes.jpg'},
        ],
        prompt: 'المس التفاحة ثم الموزة ثم البرتقالة',
        category: 'fruits',
      ),
    ];
  }

  String _getArabicName(String englishName) {
    return _arabicNames[englishName] ?? englishName;
  }

  Future<void> _playInstruction() async {
    try {
      setState(() => _isPlaying = true);
      await _audioPlayer.setAsset(_levels[_currentLevel].instruction);
      await _audioPlayer.play();
      if (!_isDisposed) {
        setState(() => _isPlaying = false);
      }
    } catch (e) {
      if (!_isDisposed) {
        setState(() => _isPlaying = false);
      }
      debugPrint('Error playing instruction: $e');
    }
  }

  void _handleObjectTap(String name) {
    if (_isPlaying) return;

    setState(() {
      _selectedSequence.add(name);
      _checkCompletion();
    });
  }

  void _checkCompletion() {
    final current = _levels[_currentLevel];

    if (current.target is List<String>) {
      final targetSequence = current.target as List<String>;
      if (_selectedSequence.length == targetSequence.length) {
        bool correct = true;
        for (int i = 0; i < targetSequence.length; i++) {
          if (_selectedSequence[i] != targetSequence[i]) {
            correct = false;
            break;
          }
        }
        if (correct) {
          _playSound('assets/audio/SFXs/success.mp3').then((_) => _nextLevel());
        } else {
          _showErrorFeedback();
        }
      }
    } else {
      if (_selectedSequence.isNotEmpty &&
          _selectedSequence.last == current.target) {
        _playSound('assets/audio/SFXs/success.mp3').then((_) => _nextLevel());
      } else {
        _showErrorFeedback();
      }
    }
  }

  void _showErrorFeedback() {
    _playSound('assets/audio/SFXs/fail.mp3');
    setState(() => _showError = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (!_isDisposed) {
        setState(() {
          _showError = false;
          _selectedSequence.clear();
        });
      }
    });
  }

  Future<void> _playSound(String path) async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.setAsset(path);
      await _audioPlayer.play();
    } catch (e) {
      debugPrint('Error playing sound: $e');
    }
  }

  void _nextLevel() {
    if (_currentLevel < _levels.length - 1) {
      setState(() {
        _currentLevel++;
        _selectedSequence.clear();
      });
    } else {
      _showCompletionDialog();
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('أحسنت!'),
        content: const Text('لقد أكملت جميع المستويات!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentLevel = 0;
                _selectedSequence.clear();
                _levels = _selectLevelsWithProgression(15);
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
    _isDisposed = true;
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final current = _levels[_currentLevel];
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('الاستماع والتنفيذ - المستوى ${_currentLevel + 1}'),
        backgroundColor: theme.customThemeData.darkPrimaryGradient.colors.first,
        actions: [
          IconButton(
            icon: const Icon(Icons.volume_up),
            onPressed: _isPlaying ? null : _playInstruction,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                current.prompt,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 30),
              if (_showError)
                Text(
                  'حاول مرة أخرى!',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: Colors.red,
                  ),
                ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: current.objects.map((obj) {
                  return GestureDetector(
                    onTap: () => _handleObjectTap(obj['name']!),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _selectedSequence.contains(obj['name']!)
                                  ? Colors.green
                                  : Colors.transparent,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset(
                            obj['image']!,
                            width: 100,
                            height: 100,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.image, size: 100),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _getArabicName(obj['name']!),
                          style: theme.textTheme.labelLarge,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
