import 'package:cheeky_chewer/components/header_text_widget.dart';
import 'package:cheeky_chewer/components/highkon_widget.dart';
import 'package:cheeky_chewer/components/action_button_widget.dart';
import 'package:cheeky_chewer/components/rich_text_widget.dart';
import 'package:cheeky_chewer/models/log.dart';
import 'package:cheeky_chewer/screens/forgot_password.dart';
import 'package:cheeky_chewer/screens/register.dart';
import 'package:cheeky_chewer/utilities/constants.dart';
import 'package:cheeky_chewer/utilities/functions.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

import 'forgot_password.dart';

class Login extends StatefulWidget {
  static String id = 'login';
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  bool showSpinner = false;
  late TapGestureRecognizer _tapGestureRecognizerForgotPassword;
  late TapGestureRecognizer _tapGestureRecognizerSignIn;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizerForgotPassword = TapGestureRecognizer();
    _tapGestureRecognizerSignIn = TapGestureRecognizer();
  }

  @override
  void dispose() {
    _tapGestureRecognizerForgotPassword.dispose();
    _tapGestureRecognizerSignIn.dispose();
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
                      headerTextString: 'Welcome\nback!',
                    ),
                    KLarger,
                    TextFormField(
                      controller: email,
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
                      controller: password,
                      obscureText: _obscureText,
                      keyboardType: TextInputType.text,
                      decoration: KTextFieldDecoration.copyWith(
                        hintText: 'Password',
                        prefixIcon: Highkon(
                          icondata: FontAwesomeIcons.lock,
                        ),
                        suffixIcon: InkWell(
                          onTap: _toggle,
                          child: Icon(
                            _obscureText
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            size: 15.0,
                            color: const Color(0xffF6AB36),
                          ),
                        ),
                      ),
                      validator: (value) {
                        return validatePassword(value);
                      },
                    ),
                    KSmaller,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              recognizer: _tapGestureRecognizerForgotPassword
                                ..onTap = () {
                                  Navigator.pushNamed(
                                      context, ForgotPassword.id);
                                },
                              text: 'Forgot Password?',
                              style: KRichStyleUnderline,
                            ),
                          ]),
                        )
                      ],
                    ),
                    KLarger,
                    ActionButton(
                      action: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        if (_formKey.currentState!.validate()) {
                          try {
                            await Log()
                                .login(context, email.text, password.text);
                          } catch (e) {
                            showErrorMsg(context, e.toString());
                          }
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      },
                      actionString: 'Sign in',
                    ),
                    KSmaller,
                    RichTexts(
                      suggestion: 'Don\'t have an account? ',
                      suggestionAction: 'Sign up',
                      suggestionActionRoute: Register.id,
                      tapGestureRecognizer: _tapGestureRecognizerSignIn,
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
