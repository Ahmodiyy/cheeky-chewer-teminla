import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String actionString;
  final Function action;

  ActionButton({
    required this.actionString,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.all(
              20,
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            const Color(0xffF6AB36),
          ),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
        ),
        onPressed: () async {
          await action();
        },
        child: Text(
          actionString,
          style: const TextStyle(
            fontSize: 20,
          ),
        ));
  }
}
