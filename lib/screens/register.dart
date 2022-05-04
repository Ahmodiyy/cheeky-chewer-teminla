import 'package:cheeky_chewer/components/header_text_widget.dart';
import 'package:cheeky_chewer/components/highkon_widget.dart';
import 'package:cheeky_chewer/components/action_button_widget.dart';
import 'package:cheeky_chewer/components/rich_text_widget.dart';
import 'package:cheeky_chewer/models/log.dart';
import 'package:cheeky_chewer/utilities/constants.dart';
import 'package:cheeky_chewer/utilities/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

import 'login.dart';

class Register extends StatefulWidget {
  static String id = 'register';
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obscureText = true;
  bool _obscureText2 = true;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  bool showSpinner = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TapGestureRecognizer _tapGestureRecognizer;
  late TapGestureRecognizer _tapGestureRecognizer2;
  late TapGestureRecognizer _tapGestureRecognizer3;
  late TapGestureRecognizer _tapGestureRecognizer4;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer();
    _tapGestureRecognizer2 = TapGestureRecognizer();
    _tapGestureRecognizer3 = TapGestureRecognizer();
    _tapGestureRecognizer4 = TapGestureRecognizer();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _tapGestureRecognizer.dispose();
    _tapGestureRecognizer2.dispose();
    _tapGestureRecognizer3.dispose();
    _tapGestureRecognizer4.dispose();
    super.dispose();
  }

  void togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void togglePassword2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
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
                      headerTextString: 'Create an \naccount',
                    ),
                    KLarger,
                    TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: KTextFieldDecoration.copyWith(
                        hintText: 'Email Address',
                        prefixIcon: Highkon(
                          icondata: FontAwesomeIcons.user,
                        ),
                      ),
                      validator: (value) {
                        return validateEmail(value);
                      },
                    ),
                    KSmaller,
                    TextFormField(
                      controller: _password,
                      obscureText: _obscureText,
                      keyboardType: TextInputType.text,
                      decoration: KTextFieldDecoration.copyWith(
                        hintText: 'Password',
                        prefixIcon: Highkon(
                          icondata: FontAwesomeIcons.lock,
                        ),
                        suffixIcon: InkWell(
                          onTap: togglePassword,
                          child: Icon(
                            _obscureText
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            size: 15.0,
                            color: KActionColor,
                          ),
                        ),
                      ),
                      validator: (value) {
                        return validatePassword(value);
                      },
                    ),
                    KSmaller,
                    TextFormField(
                      controller: _confirmPassword,
                      obscureText: _obscureText2,
                      keyboardType: TextInputType.text,
                      decoration: KTextFieldDecoration.copyWith(
                        hintText: 'Confirm password',
                        prefixIcon: Highkon(
                          icondata: FontAwesomeIcons.lock,
                        ),
                        suffixIcon: InkWell(
                          onTap: togglePassword2,
                          child: Icon(
                            _obscureText2
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            size: 15.0,
                            color: KActionColor,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm password';
                        }
                        if (_password.text != _confirmPassword.text) {
                          return "Password does not match";
                        }
                        return null;
                      },
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
                          text: 'Sign Up ',
                          style: KActionStyle,
                        ),
                        TextSpan(
                          text: 'button, ',
                          style: KRichStyle,
                        ),
                        TextSpan(
                          text: 'you agree to our ',
                          style: KRichStyle,
                        ),
                        TextSpan(
                          recognizer: _tapGestureRecognizer2..onTap = () {},
                          text: 'Terms & Condition ',
                          style: KRichStyleUnderline,
                        ),
                        TextSpan(
                          text: 'and ',
                          style: KRichStyle,
                        ),
                        TextSpan(
                          recognizer: _tapGestureRecognizer3..onTap = () {},
                          text: 'Privacy Policy.',
                          style: KRichStyleUnderline,
                        ),
                      ]),
                    ),
                    KSmaller,
                    ActionButton(
                      actionString: 'Sign up',
                      action: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        if (_formKey.currentState!.validate()) {
                          await Log().register(context, _email.text.trim(),
                              _password.text.trim());
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      },
                    ),
                    KSmaller,
                    RichTexts(
                      suggestion: 'Already have an account? ',
                      suggestionAction: 'Sign in',
                      suggestionActionRoute: Login.id,
                      tapGestureRecognizer: _tapGestureRecognizer4,
                    ),
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
