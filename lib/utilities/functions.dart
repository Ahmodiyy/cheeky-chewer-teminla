import 'package:cheeky_chewer/utilities/constants.dart';
import 'package:flutter/material.dart';

void showErrorMsg(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.white,
      content: Text(
        msg,
        style: const TextStyle(color: Colors.red),
      ),
    ),
  );
}

void showMsg(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        msg,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter email';
  }
  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
    return 'Please enter a valid email';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter password';
  }

  return null;
}

String? validate(String? value) {
  if (value == null || value.isEmpty) {
    return 'Provide input value';
  }

  return null;
}

DropdownMenuItem<String> listMenuItem(String value) {
  return DropdownMenuItem(
    value: value,
    child: Text(value),
  );
}

Container returningRecipeInfoWidget(String recipeInfo) {
  return Container(
    decoration: BoxDecoration(
      color: constantActionColor,
      borderRadius: BorderRadius.circular(20),
    ),
    padding: EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 10,
    ),
    child: Text(recipeInfo),
  );
}

List<Widget> returningListTextWidgets(
    int numbersOfItems, List<String> listItems, bool orderedList) {
  List<Widget> textWidgets = [];
  for (int holdIndex = 0; holdIndex < numbersOfItems; holdIndex++) {
    textWidgets.add(Text(
        '${orderedList ? '${holdIndex + 1}. ' : '. '} ${listItems[holdIndex]}'));
  }
  return textWidgets;
}
