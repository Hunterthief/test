import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart'; // Import the just_audio package
//import '../custom_app_bar.dart';
import 'input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen() : super();

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  late AudioPlayer _player; // Declare the audio player

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer(); // Initialize the audio player
  }

  @override
  void dispose() {
    _player.dispose(); // Dispose the audio player
    super.dispose();
  }

  Future<void> _playSuccessSound() async {
    try {
      await _player.setAsset(
          'assets/audio/SFXs/children-yay-sfx.wav'); // Ensure the path to your sound file
      _player.play();
    } catch (e) {
      print("Error playing sound: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _isDarkModeActive = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor:
            _isDarkModeActive ? Color(0xFF3D0F5D) : Color(0xffa18dd0),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _isDarkModeActive
                ? [Color(0xFF3D0F5D), Color(0xff100b55)] // Dark mode colors
                : [Color(0xffa18dd0), Color(0xff27a5b5)], // Light mode colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomInputField(
                          keyboardType: TextInputType.emailAddress,
                          hintText: "Email",
                          controller: _emailController,
                          validator: (String? email) {
                            if (email == null) {
                              return null;
                            }
                            bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(email);
                            return emailValid ? null : "Email is not valid";
                          },
                        ),
                        SizedBox(height: 24),
                        CustomInputField(
                          keyboardType: TextInputType.visiblePassword,
                          hintText: "Password",
                          obscureText: true,
                          controller: _passwordController,
                          validator: (String? password) {
                            if (password == null) {
                              return null;
                            }
                            if (password.length < 6) {
                              return "Password is too short";
                            }
                          },
                        ),
                        SizedBox(height: 24),
                        CustomInputField(
                          keyboardType: TextInputType.visiblePassword,
                          hintText: "Confirm Password",
                          obscureText: true,
                          controller: _confirmPasswordController,
                          validator: (String? confirmPassword) {
                            if (confirmPassword == null) {
                              return null;
                            }
                            if (confirmPassword != _passwordController.text) {
                              return "Passwords do not match";
                            }
                          },
                        ),
                        SizedBox(height: 24),
                        ElevatedButton(
                          child: Text("Sign Up"),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Registration successful')),
                              );
                              await _playSuccessSound(); // Play sound on successful registration
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/home', (_) => false);
                            }
                          },
                        ),
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                color: Color(0xFFb8b8b8),
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor:
                                    Colors.purple, // Set link color to purple
                              ),
                              child: Text("Sign In"),
                              onPressed: () {
                                Navigator.of(context).pushNamed("/login");
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
