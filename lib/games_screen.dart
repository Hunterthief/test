import 'package:flutter/material.dart';
import '/widgets/custom_app_bar.dart';
import '/widgets/custom_drawer.dart';
import '/theme.dart';
import 'games/games.dart';

class GamesScreen extends StatelessWidget {
  final bool isChildModeActive;
  final bool isDarkModeActive;
  final void Function(bool) toggleDarkMode;
  final void Function(bool) toggleChildMode;

  const GamesScreen({
    super.key,
    required this.isChildModeActive,
    required this.isDarkModeActive,
    required this.toggleDarkMode,
    required this.toggleChildMode,
  });

  List<Map<String, dynamic>> get games => [
        {
          'name': 'لعبة الكروت',
          'emoji': '🃏',
          'builder': (context) => CategorySelectionScreen(
                isDarkModeActive: isDarkModeActive,
              ),
        },
        {
          'name': 'تمرين الأصوات',
          'emoji': '🎵',
          'builder': (context) => const PhonemePracticeGame(),
        },
        {
          'name': 'بناء الجمل',
          'emoji': '🧩',
          'builder': (context) => const SentenceBuilderGame(),
        },
        {
          'name': 'وقت القافية',
          'emoji': '🎶',
          'builder': (context) => const RhymeTimeGame(),
        },
        {
          'name': 'كشف الأزواج',
          'emoji': '🔍',
          'builder': (context) => const MinimalPairsGame(),
        },
        {
          'name': 'القصة التفاعلية',
          'emoji': '📖',
          'builder': (context) => const StorytellingGame(),
        },
        {
          'name': 'تحديد اللسان',
          'emoji': '🌀',
          'builder': (context) => const TongueTwisterGame(),
        },
        {
          'name': 'الاستماع والتنفيذ',
          'emoji': '👂',
          'builder': (context) => const ListeningGame(),
        },
        {
          'name': 'تمثيل المشاعر',
          'emoji': '🎭',
          'builder': (context) => const EmotionCharadesGame(),
        },
        // Add the new games we've created:
        {
          'name': 'بنجو الكلمات',
          'emoji': '🎯',
          'builder': (context) => const WordBingo(
                categories: ['animals', 'fruits'], // Default categories
              ),
        },
        {
          'name': 'تصنيف المجموعات',
          'emoji': '🗂️',
          'builder': (context) => const CategorySort(
                categories: ['animals', 'fruits', 'vegetables'],
              ),
        },
        {
          'name': 'تسلسل القصص',
          'emoji': '📜',
          'builder': (context) => const StorySequence(
                categories: ['animals', 'careers'],
              ),
        },
        {
          'name': 'مقارنة الأصوات',
          'emoji': '🎤',
          'builder': (context) => const VoiceComparison(
                categories: ['animals', 'fruits'],
              ),
        },
        {
          'name': 'مطاردة الكنز',
          'emoji': '🏆',
          'builder': (context) => const ScavengerHunt(
                categories: ['animals', 'household items'],
              ),
        },
      ];

  void _showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _launchGame(
      BuildContext context, Widget Function(BuildContext) builder) async {
    try {
      // Test if the game would load by building it
      final testWidget = builder(context);
      if (testWidget.key == null) {
        // Simple check - you might want more robust validation
        Navigator.push(
          context,
          MaterialPageRoute(builder: builder),
        );
      }
    } catch (e) {
      _showToast(context, 'هذه اللعبة غير جاهزة بعد');
      debugPrint('Game load error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        onDarkModeToggle: () => toggleDarkMode(!isDarkModeActive),
        onLanguageChange: () {},
        onChildModeToggle: () => toggleChildMode(!isChildModeActive),
        isChildModeActive: isChildModeActive,
      ),
      drawer: CustomDrawer(
        onDarkModeToggle: () => toggleDarkMode(!isDarkModeActive),
        onLanguageChange: () {},
        onChildModeToggle: () => toggleChildMode(!isChildModeActive),
        isChildModeActive: isChildModeActive,
        isDarkModeActive: isDarkModeActive,
        onDarkModeChanged: toggleDarkMode,
        onChildModeChanged: toggleChildMode,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDarkModeActive
              ? theme.customThemeData.darkPrimaryGradient
              : theme.customThemeData.lightPrimaryGradient,
        ),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            constraints: const BoxConstraints(maxWidth: 800),
            decoration: BoxDecoration(
              gradient: isDarkModeActive
                  ? theme.customThemeData.darkModeContainerGradient
                  : theme.customThemeData.lightSecondaryGradient,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'الألعاب التعليمية',
                  style: theme.textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.separated(
                    itemCount: games.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 15),
                    itemBuilder: (context, index) {
                      final game = games[index];
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () => _launchGame(context, game['builder']),
                        child: Text(
                          '${game['emoji']} ${game['name']}',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
