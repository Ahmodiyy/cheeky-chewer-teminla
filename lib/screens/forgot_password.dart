import 'package:cheeky_chewer/components/header_text_widget.dart';
import 'package:cheeky_chewer/components/highkon_widget.dart';
import 'package:cheeky_chewer/components/action_button_widget.dart';
import 'package:cheeky_chewer/components/rich_text_widget.dart';
import 'package:cheeky_chewer/utilities/constants.dart';
import 'package:cheeky_chewer/utilities/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

import 'login.dart';

class ForgotPassword extends StatefulWidget {
  static String id = 'forgotpassword';
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late String email;
  bool showSpinner = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
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
                      headerTextString: 'Forgot\nPassword?',
                    ),
                    KLarger,
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: KTextFieldDecoration.copyWith(
                        hintText: 'Enter email',
                        prefixIcon:
                            Highkon(icondata: FontAwesomeIcons.envelope),
                      ),
                      validator: (value) {
                        return validateEmail(value);
                      },
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                    KSmaller,
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            textBaseline: TextBaseline.alphabetic,
                            color: KActionColor,
                          ),
                        ),
                        TextSpan(
                          text:
                              'We will send you a message to reset your password',
                          style: KRichStyle,
                        ),
                      ]),
                    ),
                    KSmaller,
                    ActionButton(
                      action: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        if (_formKey.currentState!.validate()) {
                          try {
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: email)
                                .then(
                                  (value) => showMsg(context,
                                      'Check your inbox to reset password.'),
                                );
                          } catch (e) {
                            showErrorMsg(context, e.toString());
                          }
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      },
                      actionString: 'Send Code',
                    ),
                    KSmaller,
                    RichTexts(
                      suggestion: '',
                      suggestionAction: 'Go back!',
                      suggestionActionRoute: Login.id,
                      tapGestureRecognizer: _tapGestureRecognizer,
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
