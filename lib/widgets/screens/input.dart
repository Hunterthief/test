import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final TextInputType? keyboardType;
  final String? hintText;
  final bool obscureText;
  final FormFieldValidator<String>? validator;

  const CustomInputField({
    this.controller,
    this.initialValue,
    this.keyboardType,
    this.hintText,
    this.obscureText = false,
    this.validator,
  });

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _obscure = false;

  @override
  void initState() {
    super.initState();
    if (widget.obscureText) {
      _obscure = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the current theme
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode
            ? Colors.black
            : Color(0xFFf1f0f5), // Black background in dark mode
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        controller: widget.controller,
        initialValue: widget.initialValue,
        keyboardType: widget.keyboardType,
        obscureText: _obscure,
        obscuringCharacter: '*',
        validator: widget.validator,
        style: TextStyle(
            color: isDarkMode
                ? Colors.white
                : Colors.black), // White text in dark mode
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintText: widget.hintText,
          hintStyle: TextStyle(
              color: isDarkMode
                  ? Colors.grey[400]
                  : Colors.grey[700]), // Lighter hint text in dark mode
          suffixIcon: widget.obscureText
              ? Padding(
                  padding: EdgeInsets.all(4),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(64),
                      child: Icon(
                        _obscure ? Icons.visibility : Icons.visibility_off,
                        color: isDarkMode
                            ? Colors.white
                            : Colors.black, // Icon color based on mode
                      ),
                      onTap: () {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final void Function(bool? value) onChanged;
  final String? labelText;
  final Widget? label;

  const CustomCheckbox({
    this.value = false,
    required this.onChanged,
    this.labelText,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        if (labelText != null)
          GestureDetector(
            child: Text(labelText!),
            onTap: () => onChanged(!value),
          )
        else if (label != null)
          GestureDetector(
            child: label,
            onTap: () => onChanged(!value),
          )
      ],
    );
  }
}
