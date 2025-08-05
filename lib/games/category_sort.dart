import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'game_utils.dart' as utils;

class CategorySort extends StatefulWidget {
  final List<String> categories;
  const CategorySort({super.key, required this.categories});

  @override
  State<CategorySort> createState() => _CategorySortState();
}

class _CategorySortState extends State<CategorySort> {
  final Map<String, List<Map<String, String>>> _categoryItems = {};
  final List<Map<String, String>> _draggedItems = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadAllCategories();
  }

  Future<void> _loadAllCategories() async {
    final tempCategoryItems = <String, List<Map<String, String>>>{};
    final tempDraggedItems = <Map<String, String>>[];

    for (final category in widget.categories) {
      try {
        final manifestPath = utils.categoryManifests[category]!;
        final manifestContent = await rootBundle.loadString(manifestPath);
        final manifestJson =
            json.decode(manifestContent) as Map<String, dynamic>;

        final images = (manifestJson['images'] as List).map((image) {
          final imageName = image as String;
          return {
            'name': imageName.split('.')[0],
            'image': 'assets/images/skills/$category/$imageName',
            'category': category
          };
        }).toList();

        tempCategoryItems[category] = images;
        tempDraggedItems.addAll(images);
      } catch (e) {
        setState(() {
          _errorMessage = 'Error loading $category: ${e.toString()}';
        });
        debugPrint('Error loading $category: $e');
      }
    }

    if (mounted) {
      setState(() {
        _categoryItems.addAll(tempCategoryItems);
        _draggedItems.addAll(tempDraggedItems..shuffle());
        _isLoading = false;
      });
    }
  }

  void _handleDrop(String category, Map<String, String> item) {
    if (item['category'] == category) {
      setState(() => _draggedItems.remove(item));
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
    if (_categoryItems.isEmpty) {
      return const Center(child: Text('No categories loaded'));
    }

    return Column(
      children: [
        SizedBox(
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _categoryItems.keys.map((category) {
              return DragTarget<Map<String, String>>(
                onAcceptWithDetails: (details) =>
                    _handleDrop(category, details.data),
                builder: (context, _, __) {
                  return Container(
                    width: 120,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(child: Text(category)),
                  );
                },
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.8,
            ),
            itemCount: _draggedItems.length,
            itemBuilder: (context, index) {
              final item = _draggedItems[index];
              return LongPressDraggable<Map<String, String>>(
                data: item,
                feedback: Material(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Image.asset(item['image']!, width: 80),
                      Text(utils.arabicNames[item['name']] ?? item['name']!),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Image.asset(item['image']!, width: 80),
                    Text(utils.arabicNames[item['name']] ?? item['name']!),
                    Text(item['category']!,
                        style: const TextStyle(fontSize: 12)),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
