import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'game_utils.dart' as utils;

class StorySequence extends StatefulWidget {
  final List<String> categories;
  const StorySequence({super.key, required this.categories});

  @override
  State<StorySequence> createState() => _StorySequenceState();
}

class _StorySequenceState extends State<StorySequence> {
  late List<Map<String, dynamic>> _storyFrames = [];
  bool _isLoading = true;
  bool _showSuccess = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadStoryFrames();
  }

  Future<void> _loadStoryFrames() async {
    final allFrames = <Map<String, dynamic>>[];

    for (final category in widget.categories) {
      try {
        final manifestPath = utils.categoryManifests[category]!;
        final manifestContent = await rootBundle.loadString(manifestPath);
        final manifestJson =
            json.decode(manifestContent) as Map<String, dynamic>;

        final categoryFrames = (manifestJson['images'] as List).map((image) {
          final imageName = image as String;
          return {
            'name': imageName.split('.')[0],
            'image': 'assets/images/skills/$category/$imageName',
            'category': category
          };
        }).toList();

        allFrames.addAll(categoryFrames);
      } catch (e) {
        setState(() {
          _errorMessage = 'Error loading $category: ${e.toString()}';
        });
        debugPrint('Error loading $category: $e');
      }
    }

    if (mounted) {
      setState(() {
        _storyFrames = allFrames
          ..shuffle()
          ..asMap().forEach((index, frame) => frame['correctPosition'] = index);
        _isLoading = false;
      });
    }
  }

  void _checkSequence() {
    bool isCorrect = true;
    for (int i = 0; i < _storyFrames.length; i++) {
      if (_storyFrames[i]['correctPosition'] != i) {
        isCorrect = false;
        break;
      }
    }

    setState(() => _showSuccess = isCorrect);
    if (isCorrect) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() => _showSuccess = false);
        }
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
    if (_storyFrames.isEmpty) {
      return const Center(child: Text('No items found'));
    }

    return Stack(
      children: [
        ReorderableListView(
          padding: const EdgeInsets.all(16),
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if (newIndex > oldIndex) newIndex--;
              final item = _storyFrames.removeAt(oldIndex);
              _storyFrames.insert(newIndex, item);
              _checkSequence();
            });
          },
          children: _storyFrames.map((frame) {
            return Card(
              key: ValueKey(frame['image']),
              child: ListTile(
                leading: Image.asset(frame['image'], width: 60),
                title: Text(utils.arabicNames[frame['name']] ?? frame['name']),
                subtitle: Text(frame['category']),
                trailing: const Icon(Icons.drag_handle),
              ),
            );
          }).toList(),
        ),
        if (_showSuccess)
          Positioned.fill(
            child: Container(
              color: Colors.green.withOpacity(0.5),
              child: const Center(
                child: Text('Correct Sequence!',
                    style: TextStyle(fontSize: 32, color: Colors.white)),
              ),
            ),
          ),
      ],
    );
  }
}
