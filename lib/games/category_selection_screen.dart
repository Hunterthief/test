import 'package:flutter/material.dart';
import 'cards_game.dart';
import '../theme.dart'; // Import the theme file

class CategorySelectionScreen extends StatelessWidget {
  final bool isDarkModeActive;

  CategorySelectionScreen({required this.isDarkModeActive});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customThemeData = theme.customThemeData;

    return Scaffold(
      appBar: AppBar(
        title: Text('اختر فئتك المفضلة'),
        backgroundColor: isDarkModeActive
            ? customThemeData.darkPrimaryGradient.colors.first
            : customThemeData.lightPrimaryGradient.colors.first,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDarkModeActive
              ? customThemeData.darkPrimaryGradient
              : customThemeData.lightPrimaryGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 2, // Number of columns
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            children: <Widget>[
              _buildCategoryButton(
                context,
                'الحيوانات', // Arabic for "Animals"
                'assets/images/skills/animals/cover.jpg', // Update with your image asset path
                () => _startGame(context, 'animals'),
              ),
              _buildCategoryButton(
                context,
                'فواكه', // Arabic for "Fruits"
                'assets/images/skills/fruits/cover.jpg', // Update with your image asset path
                () => _startGame(context, 'fruits'),
              ),
              _buildCategoryButton(
                context,
                'خضراوات', // Arabic for "Vegetables"
                'assets/images/skills/vegetables/cover.jpg', // Update with your image asset path
                () => _startGame(context, 'vegetables'),
              ),
              _buildCategoryButton(
                context,
                'أدوات منزل', // Arabic for "Household Items"
                'assets/images/skills/household_items/cover.jpg', // Update with your image asset path
                () => _startGame(context, 'household_items'),
              ),
              _buildCategoryButton(
                context,
                'ملابس', // Arabic for "Clothing"
                'assets/images/skills/clothing/cover.jpg', // Update with your image asset path
                () => _startGame(context, 'clothing'),
              ),
              _buildCategoryButton(
                context,
                'أجزاء الجسم', // Arabic for "Body Parts"
                'assets/images/skills/body_parts/cover.jpg', // Update with your image asset path
                () => _startGame(context, 'body_parts'),
              ),
              _buildCategoryButton(
                context,
                'حشرات', // Arabic for "Insects"
                'assets/images/skills/insects/cover.jpg', // Update with your image asset path
                () => _startGame(context, 'insects'),
              ),
              _buildCategoryButton(
                context,
                'أدوات مدرسية', // Arabic for "School Supplies"
                'assets/images/skills/school_supplies/cover.jpg', // Update with your image asset path
                () => _startGame(context, 'school_supplies'),
              ),
              /* _buildCategoryButton(
                context,
                'الألوان', // Arabic for "Colors"
                'assets/images/skills/colors/cover.jpg', // Update with your image asset path
                () => _startGame(context, 'colors'),
              ),*/
              _buildCategoryButton(
                context,
                'مواصلات', // Arabic for "Transportation"
                'assets/images/skills/transportation/cover.jpg', // Update with your image asset path
                () => _startGame(context, 'transportation'),
              ),
              _buildCategoryButton(
                context,
                'الوظائف', // Arabic for "Careers"
                'assets/images/skills/careers/cover.jpg', // Update with your image asset path
                () => _startGame(context, 'careers'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context, String text,
      String imagePath, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(
              color: Colors.white, // Set text color to white
              fontSize: 16,
              fontFamily: 'Comic Sans MS', // Ensure font is consistent
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _startGame(BuildContext context, String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          // Implement your game start logic based on the selected category
          // You may need to create a GamePage or similar widget that accepts category
          return GamePage(category: category);
        },
      ),
    );
  }
}
