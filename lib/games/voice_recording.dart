import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:convert';
import 'game_utils.dart' as utils;

class VoiceComparison extends StatefulWidget {
  final List<String> categories;
  const VoiceComparison({super.key, required this.categories});

  @override
  State<VoiceComparison> createState() => _VoiceComparisonState();
}

class _VoiceComparisonState extends State<VoiceComparison> {
  final AudioPlayer _modelPlayer = AudioPlayer();
  late List<Map<String, String>> _items = [];
  int _currentIndex = 0;
  bool _isLoading = true;
  bool _isRecording = false;
  bool _showComparison = false;
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
    }
  }

  void _playModel() async {
    if (_items.isEmpty) return;
    try {
      await _modelPlayer.setAsset(_items[_currentIndex]['audio']!);
      await _modelPlayer.play();
    } catch (e) {
      debugPrint('Error playing audio: $e');
    }
  }

  void _startRecording() {
    setState(() => _isRecording = true);
    // Implement actual recording logic
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isRecording = false;
          _showComparison = true;
        });
      }
    });
  }

  void _nextItem() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _items.length;
      _showComparison = false;
    });
  }

  @override
  void dispose() {
    _modelPlayer.dispose();
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _items[_currentIndex]['category']!,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Image.asset(_items[_currentIndex]['image']!, height: 120),
        const SizedBox(height: 20),
        Text(
          utils.arabicNames[_items[_currentIndex]['name']] ??
              _items[_currentIndex]['name']!,
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _playModel,
              child: const Text('Listen'),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: _isRecording ? null : _startRecording,
              child: _isRecording
                  ? const CircularProgressIndicator()
                  : const Text('Record'),
            ),
          ],
        ),
        if (_showComparison) ...[
          const SizedBox(height: 30),
          const Text('Your Recording vs Model:'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _nextItem,
            child: const Text('Next'),
          ),
        ],
      ],
    );
  }
}
