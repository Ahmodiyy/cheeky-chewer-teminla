import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RichButtonAsync extends StatelessWidget {
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
      onPressed: () {},
      child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 3,
      ),
    );
  }
}
