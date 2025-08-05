import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'package:SoFlu/widgets/screens/pop_up_screen.dart';

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Lock orientation to portrait mode initially
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    _controller = VideoPlayerController.asset('assets/videos/Opening.mp4')
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });

    // Listen for when the video finishes
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        _showPopUp();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    // Reset orientation preferences when disposing
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.dispose();
  }

  Future<void> _showPopUp() async {
    // Store that the video has been watched in SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenVideo', true);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopUpScreen(); // Show the custom pop-up screen
      },
    );
  }

  void _skipVideo() {
    _controller.seekTo(_controller.value.duration);
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _controller.value.isInitialized
                ? Transform(
                    transform: Matrix4.identity()
                      ..rotateZ(orientation == Orientation.portrait
                          ? 3.1415926535897932 / 2
                          : 0)
                      ..scale(orientation == Orientation.portrait ? 1.5 : 1.0,
                          orientation == Orientation.portrait ? 1.5 : 1.0),
                    alignment: Alignment.center,
                    child: AspectRatio(
                      aspectRatio: orientation == Orientation.portrait
                          ? 16 / 9
                          : _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  )
                : CircularProgressIndicator(),
          ),
          Positioned(
            top: 40.0,
            right: 10.0,
            child: ElevatedButton(
              onPressed: _skipVideo,
              child: Text("Skip"),
            ),
          ),
        ],
      ),
    );
  }
}
