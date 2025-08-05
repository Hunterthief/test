import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:convert';
import 'game_utils.dart' as utils;

class WordBingo extends StatefulWidget {
  final List<String> categories;
  const WordBingo({super.key, required this.categories});

  @override
  State<WordBingo> createState() => _WordBingoState();
}

class _WordBingoState extends State<WordBingo> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<int> _selectedIndices = [];
  late List<Map<String, String>> _items = [];
  int _currentWordIndex = 0;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCategoryItems();
  }

  Future<void> _loadCategoryItems() async {
    final allItems = <Map<String, String>>[];

    for (final category in widget.categories) {
      try {
        final manifestPath = utils.categoryManifests[category]!;
        final manifestContent = await rootBundle.loadString(manifestPath);
        final manifestJson =
            json.decode(manifestContent) as Map<String, dynamic>;

        final categoryItems = (manifestJson['images'] as List).map((image) {
          final imageName = image as String;
          return {
            'name': imageName.split('.')[0],
            'image': 'assets/images/skills/$category/$imageName',
            'audio': 'assets/audio/words/${imageName.split('.')[0]}.mp3',
            'category': category
          };
        }).toList();

        allItems.addAll(categoryItems);
      } catch (e) {
        setState(() {
          _errorMessage = 'Error loading $category: ${e.toString()}';
        });
        debugPrint('Error loading $category: $e');
      }
    }

    if (mounted) {
      setState(() {
        _items = allItems..shuffle();
        _isLoading = false;
      });
      _playWord();
    }
  }

  void _playWord() async {
    if (_items.isEmpty) return;
    try {
      await _audioPlayer.setAsset(_items[_currentWordIndex]['audio']!);
      await _audioPlayer.play();
    } catch (e) {
      debugPrint('Error playing audio: $e');
    }
  }

  void _checkBingo(int index) {
    if (_items[index]['name'] == _items[_currentWordIndex]['name']) {
      setState(() {
        _selectedIndices.add(index);
        _currentWordIndex = (_currentWordIndex + 1) % _items.length;
      });
      _playWord();
    }
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
    if (_errorMessage != null) {
      return Center(child: Text(_errorMessage!));
    }
    if (_items.isEmpty) {
      return const Center(child: Text('No items found'));
    }

    return Column(
      children: [
        Text(
            utils.arabicNames[_items[_currentWordIndex]
                    ['name']] ?? // Fixed this line
                _items[_currentWordIndex]['name']!,
            style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 20),
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
            ),
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _checkBingo(index),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: _selectedIndices.contains(index)
                        ? Border.all(color: Colors.green, width: 4)
                        : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(_items[index]['image']!, height: 60),
                      Text(
                        utils.arabicNames[_items[index]['name']] ??
                            _items[index]['name']!,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
