import 'package:flutter/material.dart';
import 'package:hitek_test/common/theme/app_color.dart';
import 'package:rxdart/rxdart.dart';

class AnimatedTextField extends StatefulWidget {
  const AnimatedTextField({
    super.key,
    this.controller,
    this.isFocusedBorderWidth = 2.0,
    this.isUnfocusedBorderWidth = 1.0,
    this.isFocusedBorderColor = AppColor.DEFAULT_BLUE,
    this.isUnfocusedBorderColor = AppColor.DEFAULT_GREY,
    this.borderRadius,
    this.keyboardType,
    this.obscureText = false,
    this.cursorColor,
    this.hintText,
    this.contentPadding,
    this.textStyle,
  });

  final TextEditingController? controller;
  final double isFocusedBorderWidth;
  final double isUnfocusedBorderWidth;
  final Color isFocusedBorderColor;
  final Color isUnfocusedBorderColor;
  final BorderRadius? borderRadius;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Color? cursorColor;
  final String? hintText;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;

  @override
  State<AnimatedTextField> createState() => _AnimatedTextFieldState();
}

class _AnimatedTextFieldState extends State<AnimatedTextField> with TickerProviderStateMixin {
  final FocusNode _focusNode = FocusNode();
  final BehaviorSubject<bool> _isFocused = BehaviorSubject<bool>.seeded(false);

  late AnimationController _animationController;
  late Animation _colorTween;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      bool isFocused = _focusNode.hasFocus;
      _isFocused.add(isFocused);
      if (isFocused) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _colorTween = ColorTween(begin: widget.isUnfocusedBorderColor, end: widget.isFocusedBorderColor).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _colorTween.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _isFocused.close();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _isFocused.stream,
      builder: (context, snapshot) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: _colorTween.value,
              width: _isFocused.value ? widget.isFocusedBorderWidth : widget.isUnfocusedBorderWidth,
            ),
            borderRadius: widget.borderRadius,
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText,
            cursorColor: widget.cursorColor,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              contentPadding: widget.contentPadding,
            ),
            style: widget.textStyle,
          ),
        );
      },
    );
  }
}
