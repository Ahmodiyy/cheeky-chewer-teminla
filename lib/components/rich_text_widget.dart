import 'package:cheeky_chewer/utilities/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RichTexts extends StatelessWidget {
  RichTexts({
    required this.suggestion,
    required this.suggestionAction,
    required this.suggestionActionRoute,
    required this.tapGestureRecognizer,
  });

  final TapGestureRecognizer tapGestureRecognizer;
  final String suggestion;
  final String suggestionAction;
  final String suggestionActionRoute;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: suggestion,
            style: constantRichStyle,
          ),
          TextSpan(
            recognizer: tapGestureRecognizer
              ..onTap = () {
                Navigator.pushReplacementNamed(context, suggestionActionRoute);
              },
            text: suggestionAction,
            style: constantRichStyleUnderline,
          ),
        ]),
      ),
    );
  }
}
