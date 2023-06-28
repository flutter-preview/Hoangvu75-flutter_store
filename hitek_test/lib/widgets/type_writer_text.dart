import 'package:flutter/material.dart';

class TypeWriterText extends StatefulWidget {
  const TypeWriterText({
    super.key,
    required this.listOfText,
    this.textPauseDuration = const Duration(milliseconds: 100),
    this.textChangeDuration = const Duration(seconds: 2),
  });

  final List<String> listOfText;
  final Duration? textPauseDuration;
  final Duration? textChangeDuration;

  @override
  State<TypeWriterText> createState() => _TypeWriterTextState();
}

class _TypeWriterTextState extends State<TypeWriterText> {
  int _currentIndex = 0;
  int _currentCharIndex = 0;
  final List<String> _strings = [
    "Loading...",
  ];

  Future<void> _typeWritingAnimation() async {
    if (_currentCharIndex < _strings[_currentIndex].length) {
      _currentCharIndex++;
    } else {
      _currentIndex = (_currentIndex + 1) % _strings.length;
      await Future.delayed(const Duration(seconds: 2));
      _currentCharIndex = 0;
    }
    setState(() {});
    Future.delayed(const Duration(milliseconds: 100), () {
      _typeWritingAnimation();
    });
  }

  @override
  void initState() {
    _typeWritingAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Text(
          _strings[_currentIndex].substring(0, _currentCharIndex),
          style: const TextStyle(
            fontSize: 24,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}