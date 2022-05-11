import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const constantSmallerHorizontalSpacing = SizedBox(
  height: 20,
);

const constantLargerWhiteHorizontalSpacing = SizedBox(
  height: 40,
);

const constantTextFieldDecoration = InputDecoration(
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

const constantActionStyle = TextStyle(
  color: Color(0xffF6AB36),
);

const constantActionColor = Color(0xffF6AB36);

const constantRichStyle = TextStyle(
  color: Color(0xff8A8781),
);

const constantRichStyleUnderline = TextStyle(
  color: Color(0xffF6AB36),
  decoration: TextDecoration.underline,
);
const constantScaffoldBackgroundColor = Color(0xffFFF8EC);
const constantSearchColor = Color(0xffEFEEEE);
const constantAppColorTheme = Color(0xffFFF8EC);

const constantSearchDecoration = InputDecoration(
  border: InputBorder.none,
  prefixIcon: Icon(
    FontAwesomeIcons.search,
    color: Colors.black,
  ),
  isDense: true,
  fillColor: constantSearchColor,
  filled: true,
  hintText: 'Search',
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: constantSearchColor, width: 1.0),
    borderRadius: BorderRadius.all(
      Radius.circular(
        15,
      ),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: constantSearchColor, width: 1.0),
    borderRadius: BorderRadius.all(
      Radius.circular(
        15,
      ),
    ),
  ),
);

const constantIngredientWhiteHorizontalSpacing = SizedBox(
  height: 15,
);

const constantCurvedContainerBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(
      20,
    ),
    topRight: Radius.circular(20),
  ),
);
