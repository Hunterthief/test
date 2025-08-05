import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:math';
import 'game_utils.dart' as utils;

class ScavengerHunt extends StatefulWidget {
  final List<String> categories;
  const ScavengerHunt({super.key, required this.categories});

  @override
  State<ScavengerHunt> createState() => _ScavengerHuntState();
}

class _ScavengerHuntState extends State<ScavengerHunt> {
  late List<Map<String, dynamic>> _hiddenItems = [];
  int _targetIndex = 0;
  bool _isLoading = true;
  int _score = 0;
  String? _errorMessage;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final allItems = <Map<String, dynamic>>[];

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
            'category': category,
            'position': [
              _random.nextInt(300).toDouble() + 50,
              _random.nextInt(400).toDouble() + 50
            ],
            'isTarget': false
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

    if (allItems.isNotEmpty) {
      allItems[_targetIndex]['isTarget'] = true;
    }

    if (mounted) {
      setState(() {
        _hiddenItems = allItems;
        _isLoading = false;
      });
    }
  }

  void _handleTap(int index) {
    if (_hiddenItems[index]['isTarget']) {
      setState(() {
        _hiddenItems[index]['isTarget'] = false;
        _score++;
        _targetIndex = (_targetIndex + 1) % _hiddenItems.length;
        _hiddenItems[_targetIndex]['isTarget'] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_errorMessage != null) {
      return Center(child: Text(_errorMessage!));
    }
    if (_hiddenItems.isEmpty) {
      return const Center(child: Text('No items found'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Score: $_score'),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/scenes/background.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          ..._hiddenItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return Positioned(
              left: item['position'][0],
              top: item['position'][1],
              child: GestureDetector(
                onTap: () => _handleTap(index),
                child: Column(
                  children: [
                    Image.asset(
                      item['image'],
                      width: item['isTarget'] ? 70 : 40,
                      color: item['isTarget'] ? null : Colors.grey,
                    ),
                    if (item['isTarget'])
                      Text(
                        utils.arabicNames[item['name']] ?? item['name'],
                        style: const TextStyle(
                          color: Colors.white,
                          shadows: [Shadow(color: Colors.black, blurRadius: 3)],
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
