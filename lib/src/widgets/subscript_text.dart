import 'package:flutter/material.dart';

/// A widget that displays text with a superscript.
class SuperscriptText extends StatelessWidget {
  /// Creates a [SuperscriptText] widget.
  ///
  /// The [text] parameter represents the base text,
  /// [superScript] is the superscript text,
  /// [color] defines the color of the base text,
  /// and [superscriptColor] defines the color of the superscript text.
  const SuperscriptText({
    super.key,
    required this.text,
    required this.superScript,
    required this.color,
    required this.superscriptColor,
  });

  /// The base text to display.
  final String text;

  /// The superscript text to display.
  final String superScript;

  /// The color of the base text.
  final Color color;

  /// The color of the superscript text.
  final Color superscriptColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 40,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          superScript,
          style: TextStyle(
            color: superscriptColor,
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
