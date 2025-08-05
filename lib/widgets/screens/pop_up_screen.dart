import 'package:flutter/material.dart';

class PopUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Who is using this device?'),
      content: Text('Please select if this is a parent\'s or child\'s device.'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamed('/register'); // Navigate to SignUpScreen
          },
          child: Text('Parent'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamed('/register'); // Navigate to SignUpScreen
          },
          child: Text('Child'),
        ),
      ],
    );
  }
}
