import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const KSmaller = SizedBox(
  height: 20,
);

const KLarger = SizedBox(
  height: 40,
);

const KTextFieldDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  hintText: 'Enter',
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(
      15,
    )),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffF6AB36), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(
      15,
    )),
  ),
);

const KActionStyle = TextStyle(
  color: Color(0xffF6AB36),
);

const KActionColor = Color(0xffF6AB36);

const KRichStyle = TextStyle(
  color: Color(0xff8A8781),
);

const KRichStyleUnderline = TextStyle(
  color: Color(0xffF6AB36),
  decoration: TextDecoration.underline,
);
const KScaffoldBackground = Color(0xffFFF8EC);
const KSearchColor = Color(0xffEFEEEE);
const KAppColorTheme = Color(0xffFFF8EC);

const KSearchDecoration = InputDecoration(
  border: InputBorder.none,
  prefixIcon: Icon(
    FontAwesomeIcons.search,
    color: Colors.black,
  ),
  isDense: true,
  fillColor: KSearchColor,
  filled: true,
  hintText: 'Search',
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: KSearchColor, width: 1.0),
    borderRadius: BorderRadius.all(
      Radius.circular(
        15,
      ),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: KSearchColor, width: 1.0),
    borderRadius: BorderRadius.all(
      Radius.circular(
        15,
      ),
    ),
  ),
);
