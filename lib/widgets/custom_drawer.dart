import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For Clipboard functionality
import 'package:url_launcher/url_launcher.dart'; // For launching URLs

class CustomDrawer extends StatelessWidget {
  final VoidCallback onDarkModeToggle;
  final VoidCallback onLanguageChange;
  final VoidCallback onChildModeToggle;
  final bool isDarkModeActive;
  final bool isChildModeActive;
  final ValueChanged<bool> onDarkModeChanged;
  final ValueChanged<bool> onChildModeChanged;

  CustomDrawer({
    required this.onDarkModeToggle,
    required this.onLanguageChange,
    required this.onChildModeToggle,
    required this.isDarkModeActive,
    required this.isChildModeActive,
    required this.onDarkModeChanged,
    required this.onChildModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Settings 🛠️',
              style: theme.textTheme.titleLarge
                  ?.copyWith(color: theme.appBarTheme.titleTextStyle?.color),
            ),
            decoration: BoxDecoration(
              color: theme
                  .appBarTheme.backgroundColor, // Use app bar background color
            ),
          ),
          ListTile(
            leading: Text('🌙', style: TextStyle(fontSize: 24)),
            title: Text('Dark Mode', style: theme.textTheme.bodyLarge),
            trailing: Switch(
              value: isDarkModeActive,
              onChanged: (bool value) {
                onDarkModeChanged(value);
                onDarkModeToggle();
              },
            ),
          ),
          ListTile(
            leading: Text('👶', style: TextStyle(fontSize: 24)),
            title: Text('Child Mode', style: theme.textTheme.bodyLarge),
            subtitle: Text('Coming Soon',
                style:
                    theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
          ),
          ListTile(
            leading: Text('🌍', style: TextStyle(fontSize: 24)),
            title: Text('Language', style: theme.textTheme.bodyLarge),
            subtitle: Text('Coming Soon',
                style:
                    theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
            onTap: () {
              onLanguageChange();
            },
          ),
          Divider(), // Separate the settings from the social and support buttons

          // Adding empty buttons (using SizedBox) for spacing
          SizedBox(height: 50),
          SizedBox(height: 50),
          SizedBox(height: 50),
          SizedBox(height: 50),

          ListTile(
            leading: Text('📲', style: TextStyle(fontSize: 24)),
            title: Text('تابعنا علي وسائل التواصل الاجتماعي',
                style: theme.textTheme.bodyLarge),
            onTap: () {
              _showSocialMediaPopup(context);
            },
          ),
          ListTile(
            leading: Text('🛠️', style: TextStyle(fontSize: 24)),
            title: Text('الدعم الفني', style: theme.textTheme.bodyLarge),
            onTap: () {
              _showSupportNumbers(context);
            },
          ),
        ],
      ),
    );
  }

  void _showSocialMediaPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تابعنا علي وسائل التواصل الاجتماعي'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.star_rate),
                title: Text('Leave a Google Review'),
                onTap: () async {
                  const googleReviewUrl = 'https://www.google.com/maps/reviews';
                  if (await canLaunch(googleReviewUrl)) {
                    await launch(googleReviewUrl);
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.facebook),
                title: Text('Follow us on Facebook'),
                onTap: () async {
                  const facebookUrl =
                      'https://www.facebook.com/profile.php?id=61565464259950';
                  if (await canLaunch(facebookUrl)) {
                    await launch(facebookUrl);
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.music_note),
                title: Text('Follow us on TikTok'),
                onTap: () async {
                  const tiktokUrl =
                      'https://www.tiktok.com/@soflu.4n?_t=8paPgqogAIy&_r=1';
                  if (await canLaunch(tiktokUrl)) {
                    await launch(tiktokUrl);
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showSupportNumbers(BuildContext context) {
    final String number1 =
        "+01286024574"; // Replace with actual WhatsApp numbers
    final String number2 = "+01095668538";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('الدعم الفني'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.copy),
                title: Text('WhatsApp 1: $number1'),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: number1));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Number $number1 copied to clipboard')),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.copy),
                title: Text('WhatsApp 2: $number2'),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: number2));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Number $number2 copied to clipboard')),
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
