import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../theme.dart'; // Assuming theme.dart contains your light and dark mode styles
import 'dart:math';

class ShapesDetailScreen extends StatefulWidget {
  @override
  _ShapesDetailScreenState createState() => _ShapesDetailScreenState();
}

class _ShapesDetailScreenState extends State<ShapesDetailScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  List<Map<String, String>> get shapes => [
        {
          'shapeName': 'دائرة', // Circle
          'audio': 'assets/audio/skills/shapes/circle.mp3'
        },
        {
          'shapeName': 'مربع', // Square
          'audio': 'assets/audio/skills/shapes/square.mp3'
        },
        {
          'shapeName': 'مثلث', // Triangle
          'audio': 'assets/audio/skills/shapes/triangle.mp3'
        },
        {
          'shapeName': 'مستطيل', // Rectangle
          'audio': 'assets/audio/skills/shapes/rectangle.mp3'
        },
        {
          'shapeName': 'معين', // Diamond
          'audio': 'assets/audio/skills/shapes/diamond.mp3'
        },
        {
          'shapeName': 'بيضاوي', // Oval
          'audio': 'assets/audio/skills/shapes/oval.mp3'
        },
        {
          'shapeName': 'شكل سداسي', // Hexagon
          'audio': 'assets/audio/skills/shapes/hexagon.mp3'
        },
        {
          'shapeName': 'شكل ثماني', // Octagon
          'audio': 'assets/audio/skills/shapes/octagon.mp3'
        },
        {
          'shapeName': 'شكل غير منتظم', // Irregular Shape
          'audio': 'assets/audio/skills/shapes/irregular_shape.mp3'
        },
        {
          'shapeName': 'شكل قلب', // Heart Shape
          'audio': 'assets/audio/skills/shapes/heart.mp3'
        },
        {
          'shapeName': 'شكل نجمة', // Star Shape
          'audio': 'assets/audio/skills/shapes/star.mp3'
        },
      ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('الأشكال'), // Arabic for "Shapes"
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDarkMode ? darkModeContainerGradient : null,
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
          ),
          itemCount: shapes.length,
          itemBuilder: (context, index) {
            final shape = shapes[index];
            return GestureDetector(
              onTap: () {
                _onShapeTap(context, shape['audio'], shape['shapeName']!);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: Size(100, 100),
                      painter: ShapePainter(shape['shapeName']!),
                    ),
                    Positioned(
                      bottom: 10,
                      child: Text(
                        shape['shapeName']!,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onShapeTap(
      BuildContext context, String? audioPath, String shapeName) async {
    await _audioPlayer.stop();
    if (audioPath != null && audioPath.isNotEmpty) {
      try {
        await _audioPlayer.setAsset(audioPath);
        _audioPlayer.play();
      } catch (e) {
        print('Error playing audio: $e');
      }
    }
    // Show dialog with enlarged shape
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomPaint(
                size: Size(200, 200), // Enlarged size for shape
                painter: ShapePainter(shapeName),
              ),
              SizedBox(height: 16),
              Text(
                shapeName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  final String shapeName;
  final Paint shapePaint;

  ShapePainter(this.shapeName)
      : shapePaint = Paint()
          ..color = Colors.blue
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    switch (shapeName) {
      case 'دائرة':
        canvas.drawCircle(size.center(Offset.zero), size.width / 2, shapePaint);
        break;
      case 'مربع':
        canvas.drawRect(
          Rect.fromCenter(
            center: size.center(Offset.zero),
            width: size.width,
            height: size.height,
          ),
          shapePaint,
        );
        break;
      case 'مثلث':
        final path = Path()
          ..moveTo(size.width / 2, 0)
          ..lineTo(size.width, size.height)
          ..lineTo(0, size.height)
          ..close();
        canvas.drawPath(path, shapePaint);
        break;
      case 'مستطيل':
        canvas.drawRect(
          Rect.fromCenter(
            center: size.center(Offset.zero),
            width: size.width * 1.5,
            height: size.height,
          ),
          shapePaint,
        );
        break;
      case 'معين':
        final diamondPath = Path()
          ..moveTo(size.width / 2, 0)
          ..lineTo(size.width, size.height / 2)
          ..lineTo(size.width / 2, size.height)
          ..lineTo(0, size.height / 2)
          ..close();
        canvas.drawPath(diamondPath, shapePaint);
        break;
      case 'بيضاوي':
        canvas.drawOval(
          Rect.fromCenter(
            center: size.center(Offset.zero),
            width: size.width,
            height: size.height * 0.5,
          ),
          shapePaint,
        );
        break;
      case 'شكل سداسي':
        _drawHexagon(canvas, size);
        break;
      case 'شكل ثماني':
        _drawOctagon(canvas, size);
        break;
      case 'شكل غير منتظم':
        _drawIrregularShape(canvas, size);
        break;
      case 'شكل قلب':
        _drawHeart(canvas, size);
        break;
      case 'شكل نجمة':
        _drawStar(canvas, size);
        break;
    }
  }

  void _drawHexagon(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height / 4)
      ..lineTo(size.width, size.height * 3 / 4)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(0, size.height * 3 / 4)
      ..lineTo(0, size.height / 4)
      ..close();
    canvas.drawPath(path, shapePaint);
  }
  void _drawOctagon(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width / 4, 0)
      ..lineTo(size.width * 3 / 4, 0)
      ..lineTo(size.width, size.height / 4)
      ..lineTo(size.width, size.height * 3 / 4)
      ..lineTo(size.width * 3 / 4, size.height)
      ..lineTo(size.width / 4, size.height)
      ..lineTo(0, size.height * 3 / 4)
      ..lineTo(0, size.height / 4)
      ..close();
    canvas.drawPath(path, shapePaint);
  }

  void _drawIrregularShape(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width / 4, size.height / 4)
      ..lineTo(size.width * 3 / 4, size.height / 4)
      ..lineTo(size.width * 3 / 5, size.height * 3 / 4)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width / 5, size.height * 3 / 4)
      ..close();
    canvas.drawPath(path, shapePaint);
  }

  void _drawHeart(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width / 2, size.height * 0.3)
      ..cubicTo(size.width * 0.1, 0, 0, size.height * 0.4, size.width / 2,
          size.height)
      ..cubicTo(size.width, size.height * 0.4, size.width * 0.9, 0,
          size.width / 2, size.height * 0.3);
    canvas.drawPath(path, shapePaint);
  }

  void _drawStar(Canvas canvas, Size size) {
    final path = Path();
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = size.width / 2;

    for (int i = 0; i < 5; i++) {
      double angle = (i * 144) * (3.14 / 180);
      double x = centerX + radius * cos(angle);
      double y = centerY + radius * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, shapePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
