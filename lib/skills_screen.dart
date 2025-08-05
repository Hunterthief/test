import 'package:flutter/material.dart';
import 'Skill_details/animal_detail_screen.dart'; // Import the AnimalDetailScreen class
import 'Skill_details/careers_detail_screen.dart'; // Import the CareersDetailScreen class
import 'Skill_details/fruit_detail_screen.dart'; // Import the FruitDetailScreen class
import 'Skill_details/vegetable_detail_screen.dart'; // Import the VegetableDetailScreen class
//import 'Skill_details/kitchen_utensils_detail_screen.dart'; // Import the KitchenUtensilsDetailScreen class
import 'Skill_details/household_items_detail_screen.dart'; // Import the HouseholdItemsDetailScreen class
import 'Skill_details/clothing_detail_screen.dart'; // Import the ClothingDetailScreen class
import 'Skill_details/body_parts_detail_screen.dart'; // Import the BodyPartsDetailScreen class
import 'Skill_details/insects_detail_screen.dart'; // Import the InsectsDetailScreen class
import 'Skill_details/school_supplies_detail_screen.dart'; // Import the SchoolSuppliesDetailScreen class
import 'Skill_details/transportation_detail_screen.dart'; // Import the TransportationDetailScreen class
import 'Skill_details/colors_detail_screen.dart'; // Import the TransportationDetailScreen class
import 'Skill_details/shapes_detail_screen.dart';
import 'Skill_details/numbers_detail_screen.dart';
import 'theme.dart'; // Import the theme file

class SkillsScreen extends StatelessWidget {
  final bool isChildModeActive;
  final void Function(bool) toggleDarkMode;
  final void Function(bool) toggleChildMode;
  final bool isDarkModeActive;

  SkillsScreen({
    required this.isChildModeActive,
    required this.toggleDarkMode,
    required this.toggleChildMode,
    required this.isDarkModeActive,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customThemeData = theme.customThemeData;

    return Scaffold(
      appBar: AppBar(
        title: Text('تنمية مهارات'),
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
              _buildSkillButton(
                context,
                'الحيوانات', // Arabic for "Animals"
                'assets/images/skills/animals/cover.jpg', // Update with your image asset path
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnimalDetailScreen()),
                ),
              ),
              _buildSkillButton(
                context,
                'فواكه', // Arabic for "Fruits"
                'assets/images/skills/fruits/cover.jpg', // Update with your image asset path
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FruitDetailScreen()),
                ),
              ),
              _buildSkillButton(
                context,
                'خضراوات', // Arabic for "Vegetables"
                'assets/images/skills/vegetables/cover.jpg', // Update with your image asset path
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VegetableDetailScreen()),
                ),
              ),
              /*_buildSkillButton(
                context,
                'أدوات المطبخ', // Arabic for "Kitchen Utensils"
                'assets/images/skills/kitchen_utensils/cover.jpg', // Update with your image asset path
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => KitchenUtensilsDetailScreen()),
                ),
              ),*/
              _buildSkillButton(
                context,
                'أدوات منزل', // Arabic for "Household Items"
                'assets/images/skills/household_items/cover.jpg', // Update with your image asset path
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HouseholdItemsDetailScreen()),
                ),
              ),
              _buildSkillButton(
                context,
                'ملابس', // Arabic for "Clothing"
                'assets/images/skills/clothing/cover.jpg', // Update with your image asset path
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ClothingDetailScreen()),
                ),
              ),
              _buildSkillButton(
                context,
                'أجزاء الجسم', // Arabic for "Body Parts"
                'assets/images/skills/body_parts/cover.jpg', // Update with your image asset path
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BodyPartsDetailScreen()),
                ),
              ),
              _buildSkillButton(
                context,
                'حشرات', // Arabic for "Insects"
                'assets/images/skills/insects/cover.jpg', // Update with your image asset path
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InsectsDetailScreen()),
                ),
              ),
              _buildSkillButton(
                context,
                'أدوات مدرسية', // Arabic for "School Supplies"
                'assets/images/skills/school_supplies/cover.jpg', // Update with your image asset path
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SchoolSuppliesDetailScreen()),
                ),
              ),
              _buildSkillButton(
                context,
                'الألوان', // Arabic for "Colors"
                'assets/images/skills/colors/cover.jpg', // Update with your image asset path
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ColorsDetailScreen()),
                ),
              ),
              _buildSkillButton(
                context,
                'الاشكال', // Arabic for "Colors"
                'assets/images/skills/shapes/cover.jpg', // Update with your image asset path
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShapesDetailScreen()),
                ),
              ),
              _buildSkillButton(
                context,
                'الارقام', // Arabic for "Colors"
                'assets/images/skills/numbers/cover.jpg', // Update with your image asset path
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NumbersDetailScreen()),
                ),
              ),
              _buildSkillButton(
                context,
                'مواصلات', // Arabic for "Transportation"
                'assets/images/skills/transportation/cover.jpg', // Update with your image asset path
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TransportationDetailScreen()),
                ),
              ),
              _buildSkillButton(
                context,
                'الوظائف', // Arabic for "Transportation"
                'assets/images/skills/careers/cover.jpg', // Update with your image asset path
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CareersDetailScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillButton(BuildContext context, String text, String imagePath,
      VoidCallback onPressed) {
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
}
