import 'package:cheeky_chewer/components/action_button_widget.dart';
import 'package:flutter/material.dart';

class Ingredient extends StatelessWidget {
  Ingredient();

  final double modalBottomSheetPadding = 30;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              20,
            ),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: modalBottomSheetPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.cancel,
                    ),
                  )
                ],
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: ShapeDecoration(
                          color: Colors.grey.shade400,
                          // image: DecorationImage(
                          //   image: NetworkImage(
                          //     '',
                          //   ),
                          //   fit: BoxFit.cover,
                          // ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Text('ajfjjfjj'),
                    TextField(
                      autofocus: true,
                      keyboardType: TextInputType.multiline,
                    )
                  ],
                ),
              ),
              ActionButton(actionString: 'ViewRecipe', action: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
