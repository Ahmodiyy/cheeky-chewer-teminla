import 'package:cheeky_chewer/components/header_text_widget.dart';
import 'package:cheeky_chewer/components/highkon_widget.dart';
import 'package:cheeky_chewer/components/action_button_widget.dart';
import 'package:cheeky_chewer/models/log.dart';
import 'package:cheeky_chewer/utilities/constants.dart';
import 'package:cheeky_chewer/utilities/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

class Info extends StatefulWidget {
  static String id = 'info';
  Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  String? listValue;
  List<String> professions = [
    'Dancer',
    'Ai engineer',
    'Musician',
    'Software engineer',
    'Designer',
    'Artist',
  ];
  bool showSpinner = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TapGestureRecognizer _tapGestureRecognizer;
  TextEditingController name = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController prof = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController url = TextEditingController();

  User? user;
  Future<void> getUser() async {
    try {
      user = await Log().getUser();
      if (user != null) {
        print('user ${user!.email}');
      }
    } catch (e) {
      print('user $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
    _tapGestureRecognizer = TapGestureRecognizer();
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    KLarger,
                    HeaderText(
                      headerTextString: 'Your\nInformation',
                    ),
                    KLarger,
                    TextFormField(
                      controller: name,
                      keyboardType: TextInputType.name,
                      decoration: KTextFieldDecoration.copyWith(
                        hintText: 'Name',
                        prefixIcon: Highkon(
                          icondata: FontAwesomeIcons.user,
                        ),
                      ),
                      validator: (value) {
                        return validate(value);
                      },
                      onChanged: (value) {},
                    ),
                    KSmaller,
                    TextFormField(
                      controller: userName,
                      keyboardType: TextInputType.name,
                      decoration: KTextFieldDecoration.copyWith(
                        hintText: 'Username',
                        prefixIcon: Highkon(
                          icondata: FontAwesomeIcons.lock,
                        ),
                      ),
                      validator: (value) {
                        return validate(value);
                      },
                      onChanged: (value) {},
                    ),
                    KSmaller,
                    DropdownButtonFormField(
                      validator: (value) =>
                          value == null ? 'field required' : null,
                      decoration: KTextFieldDecoration.copyWith(
                        border: InputBorder.none,
                        prefixIcon: Highkon(
                          icondata: FontAwesomeIcons.briefcase,
                        ),
                      ),
                      icon: Icon(
                        // Add this
                        Icons.arrow_drop_down, // Add this
                        color: KActionColor, // Add this
                      ),
                      hint: Text(
                        'Profession',
                      ),
                      isExpanded: true,
                      isDense: true,
                      value: listValue,
                      onChanged: (value) => setState(() {
                        this.listValue = value.toString();
                      }),
                      items: professions
                          .map((String val) => listMenuItem(val))
                          .toList(),
                    ),
                    KSmaller,
                    TextFormField(
                      controller: url,
                      keyboardType: TextInputType.url,
                      decoration: KTextFieldDecoration.copyWith(
                        hintText: 'Profile URL',
                        prefixIcon: Highkon(
                          icondata: FontAwesomeIcons.globe,
                        ),
                      ),
                      validator: (value) {
                        return validate(value);
                      },
                      onChanged: (value) {},
                    ),
                    KSmaller,
                    TextFormField(
                      controller: bio,
                      keyboardType: TextInputType.text,
                      decoration: KTextFieldDecoration.copyWith(
                        hintText: 'Bio',
                        prefixIcon: Highkon(
                          icondata: FontAwesomeIcons.penSquare,
                        ),
                      ),
                      validator: (value) {
                        return validate(value);
                      },
                      onChanged: (value) {},
                    ),
                    KSmaller,
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'By clicking the ',
                          style: KRichStyle,
                        ),
                        TextSpan(
                          recognizer: _tapGestureRecognizer..onTap = () {},
                          text: 'Finish ',
                          style: KActionStyle,
                        ),
                        TextSpan(
                          text:
                              'button, you agree that all information here are valid',
                          style: KRichStyle,
                        ),
                      ]),
                    ),
                    KSmaller,
                    ActionButton(
                      actionString: 'Finish',
                      action: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        if (_formKey.currentState!.validate()) {
                          try {
                            await Log().loggingUserData(
                                context,
                                user!.email,
                                name.text,
                                userName.text,
                                listValue!,
                                url.text,
                                bio.text);
                          } catch (e) {
                            showErrorMsg(context, e.toString());
                          }
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      },
                    ),
                    KSmaller,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
