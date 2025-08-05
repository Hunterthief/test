import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
//import 'package:flutter/foundation.dart';
import '../theme.dart';

class GamePage extends StatefulWidget {
  final String category;

  const GamePage({required this.category});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final int totalRounds = 5;
  int currentRound = 1;
  int correctRounds = 0;
  int totalAttempts = 0;
  int incorrectAttempts = 0;
  bool _isLoading = true; // Add this line

  List<String> images = [];
  Map<String, String> imageToAudioMap = {};
  List<Map<String, dynamic>> roundsData = [];
  Map<String, bool> clickedImages = {};

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _loadImagesFromManifest();
  }

  Future<void> _loadImagesFromManifest() async {
    try {
      final manifestContent = await rootBundle.loadString(
        'assets/images/skills/${widget.category}/manifest.json',
      );
      final manifestData = jsonDecode(manifestContent);

      List<String> loadedImages = List<String>.from(manifestData['images']);
      final random = Random();

      // Ensure you only get 20 unique images
      Set<String> selectedImagesSet = {};
      while (selectedImagesSet.length < 20 &&
          selectedImagesSet.length < loadedImages.length) {
        String randomImage = loadedImages[random.nextInt(loadedImages.length)];
        selectedImagesSet.add(randomImage);
      }

      // Load only the selected images
      for (var img in selectedImagesSet) {
        String assetPath = 'assets/images/skills/${widget.category}/$img';
        if (await _assetExists(assetPath)) {
          images.add(assetPath);
          imageToAudioMap[assetPath] =
              'assets/audio/skills/${widget.category}/${img.split('.').first}.mp3';
        }
      }

      if (images.length < 20) {
        print(
            'Not enough valid images found. Expected 20, found ${images.length}.');
        return;
      }

      _preloadRounds();
    } catch (e) {
      print('Error loading manifest: $e');
    }
  }

  Future<bool> _assetExists(String assetPath) async {
    try {
      final ByteData data = await rootBundle.load(assetPath);
      return data != null;
    } catch (e) {
      return false;
    }
  }

  void _preloadRounds() {
    final random = Random();

    // Ensure enough images are available for the game
    if (images.length < 20) {
      print('Not enough images to play the game.');
      return;
    }

    // Select 20 unique images
    Set<String> selectedImagesSet = {};
    while (selectedImagesSet.length < 20) {
      String randomImage = images[random.nextInt(images.length)];
      selectedImagesSet.add(randomImage);
    }

    // Convert the set to a list for easier manipulation
    List<String> selectedImages = selectedImagesSet.toList();

    // Create rounds from the selected images
    for (int i = 0; i < totalRounds; i++) {
      // Pick 4 unique images for the current round
      List<String> roundImages = selectedImages.sublist(i * 4, (i + 1) * 4);

      // Select one of the 4 images to be the correct image (bottom image)
      String correctImage = roundImages[random.nextInt(4)];

      // Shuffle the 4 displayed images to mix up the correct image position
      roundImages.shuffle(random);

      roundsData.add({
        'correctImage': correctImage,
        'displayedImages': roundImages,
      });
    }

    // Start the game after preloading the rounds
    _startGame();
  }

  void _startGame() async {
    // Change this line
    await Future.delayed(Duration(seconds: 2)); // Add this line
    setState(() {
      _isLoading = false; // Add this line
      currentRound = 1;
      correctRounds = 0;
      totalAttempts = 0;
      incorrectAttempts = 0;
      clickedImages.clear();
      _playAudioForImage(roundsData[currentRound - 1]['correctImage']);
    });
  }

  void _nextRound() {
    if (currentRound < totalRounds) {
      setState(() {
        currentRound++;
        clickedImages.clear();
        _playAudioForImage(roundsData[currentRound - 1]['correctImage']);
      });
    } else {
      _showGameCompletedDialog();
    }
  }

  void _onImageTap(String selectedImage) async {
    setState(() {
      totalAttempts++;
    });

    if (selectedImage == roundsData[currentRound - 1]['correctImage']) {
      await _playSound('assets/audio/SFXs/success.mp3');

      setState(() {
        correctRounds++;
      });

      await Future.delayed(Duration(seconds: 1));
      _nextRound();
    } else {
      await _playSound('assets/audio/SFXs/fail.mp3');

      setState(() {
        incorrectAttempts++;
        clickedImages[selectedImage] = true;
      });
    }
  }

  Future<void> _playSound(String path) async {
    try {
      await _audioPlayer.setAsset(path);
      await _audioPlayer.play();
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  Future<void> _playAudioForImage(String imagePath) async {
    final audioPath = imageToAudioMap[imagePath];
    if (audioPath != null) {
      await _playSound(audioPath);
    }
  }

  void _showGameCompletedDialog() {
    double rating = _calculateRating();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('لقد انهيت اللعبة!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'لقد قمت بحل $correctRounds من $totalRounds في محاولة واحدة.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Rating:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 10),
            _buildStarRating(rating),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  double _calculateRating() {
    if (totalAttempts == 0) return 0;

    double accuracy = correctRounds / totalRounds;
    double rating = (accuracy * 5).clamp(0, 5);

    rating -= incorrectAttempts * (5 / totalRounds).clamp(0, 1);
    return rating.clamp(0, 5);
  }

  Widget _buildStarRating(double rating) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.yellow,
          size: 30,
        );
      }),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _audioPlayer.dispose();
    super.dispose();
  }

  Widget _buildImage(String imagePath, bool isCorrect, bool isClicked,
      Orientation orientation) {
    return Transform.rotate(
      angle: orientation == Orientation.portrait
          ? pi / 2
          : 0, // Rotate 90 degrees in portrait mode
      child: Stack(
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: 250,
            height: 250,
            errorBuilder: (context, error, stackTrace) {
              _swapImageOnError(imagePath);
              return Container();
            },
          ),
          if (isClicked && !isCorrect)
            Positioned(
              right: 0,
              top: 0,
              child: Icon(
                Icons.cancel,
                color: Colors.red,
                size: 30,
              ),
            ),
        ],
      ),
    );
  }

  void _swapImageOnError(String failedImage) {
    if (failedImage == roundsData[currentRound - 1]['correctImage']) {
      roundsData[currentRound - 1] = _getNewRoundData();
    }
  }

  Map<String, dynamic> _getNewRoundData() {
    final random = Random();
    String newCorrectImage;

    do {
      newCorrectImage = images[random.nextInt(images.length)];
    } while (
        roundsData.any((round) => round['correctImage'] == newCorrectImage));

    List<String> displayedImages = [newCorrectImage];
    while (displayedImages.length < 4) {
      String randomImage = images[random.nextInt(images.length)];
      if (!displayedImages.contains(randomImage)) {
        displayedImages.add(randomImage);
      }
    }

    displayedImages.shuffle();

    return {
      'correctImage': newCorrectImage,
      'displayedImages': displayedImages,
    };
  }

  Widget _buildBorderWithImage(String imagePath, bool isCorrect, bool isClicked,
      Orientation orientation) {
    return Container(
      height: 250,
      width: 250,
      padding: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent, width: 2.0),
        borderRadius: BorderRadius.circular(12.0),
        gradient: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).customThemeData.darkModeContainerGradient
            : null, // Default or light gradient can be added if necessary
      ),
      child: GestureDetector(
        onTap: () => _onImageTap(imagePath),
        child: _buildImage(imagePath, isCorrect, isClicked, orientation),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: _buildLoadingScreen(),
      );
    }

    final currentRoundData = roundsData[currentRound - 1];
    final displayedImages = currentRoundData['displayedImages'];
    final correctImage = currentRoundData['correctImage'];

    return Scaffold(
      appBar: AppBar(
        title: Text('الدور $currentRound من اصل $totalRounds'),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Container(
            decoration: BoxDecoration(
              gradient: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).customThemeData.darkPrimaryGradient
                  : Theme.of(context).customThemeData.lightPrimaryGradient,
            ),
            child: orientation == Orientation.portrait
                ? Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          padding: EdgeInsets.all(8.0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemCount: displayedImages.length,
                          itemBuilder: (context, index) {
                            final imagePath = displayedImages[index];
                            return _buildBorderWithImage(
                              imagePath,
                              imagePath == correctImage,
                              clickedImages[imagePath] ?? false,
                              orientation,
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 300,
                        child: _buildImage(
                          correctImage,
                          true,
                          false,
                          orientation,
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          padding: EdgeInsets.all(0.0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemCount: displayedImages.length,
                          itemBuilder: (context, index) {
                            final imagePath = displayedImages[index];
                            return _buildBorderWithImage(
                              imagePath,
                              imagePath == correctImage,
                              clickedImages[imagePath] ?? false,
                              orientation,
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: _buildImage(
                          correctImage,
                          true,
                          false,
                          orientation,
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Container(
      decoration: BoxDecoration(
        gradient: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).customThemeData.darkPrimaryGradient
            : Theme.of(context).customThemeData.lightPrimaryGradient,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              'Loading...',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
