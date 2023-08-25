import 'package:flutter/material.dart';
import 'package:test_commerce/ext/validation.dart';
import 'package:test_commerce/screens/otp_screen.dart';

import '../styles/colors.dart';
import '../widgets/input_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.versionNumber});

  final String versionNumber;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController account = TextEditingController(text: "");
  TextEditingController password = TextEditingController(text: "");
  TextEditingController rePassword = TextEditingController(text: "");
  String accountError = "";
  String passwordError = "";
  String rePasswordError = "";

  void registerValidation() {
    var accountValidation = account.text.validateAccount;
    var passwordValidation = password.text.isPasswordValid;
    var confirmValidation = rePassword.text.isPasswordConfirmed(password.text);
    setState(() {
      accountError = accountValidation;
      passwordError = passwordValidation;
      rePasswordError =
      passwordValidation.isNotEmpty ? "" : confirmValidation;
    });
    if (accountValidation.isNotEmpty ||
        passwordValidation.isNotEmpty ||
        confirmValidation.isNotEmpty) {
      return;
    }

    navigate(OtpScreen(account: account.text));
  }

  void navigate(Widget screen) {
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    Widget title = const Padding(
        padding:
            EdgeInsets.only(right: 56.0, bottom: 10.0, top: 56.0, left: 16.0),
        child: Text(
          'Register & Join Us Today',
          style: TextStyle(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
        ));

    Widget registerButton = Positioned(
      left: MediaQuery.of(context).size.width / 2.1,
      bottom: 10,
      child: InkWell(
        onTap: () {
          registerValidation();
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 56,
          decoration: BoxDecoration(
              color: accent,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                  offset: Offset(0, 5),
                  blurRadius: 10.0,
                )
              ],
              borderRadius: BorderRadius.circular(8.0)),
          child: const Center(
              child: Text("Register",
                  style: TextStyle(
                      color: Color(0xfffefefe),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 18.0))),
        ),
      ),
    );

    Widget registerForm = SizedBox(
      height: 375,
      child: Stack(
        children: <Widget>[
          Container(
            height: 340,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.8),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: InputTextField(
                      controller: account,
                      label: "Phone or Email",
                      hint: "800551234 or abc@gmail.com",
                      error: accountError,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InputTextField(
                    controller: password,
                    isPasswordField: true,
                    label: "Password",
                    hint: "Must have at least 8 characters",
                    error: passwordError,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InputTextField(
                      controller: rePassword,
                      isPasswordField: true,
                      label: "Confirm Password",
                      hint: "Retype your password",
                      error: rePasswordError),
                ),
              ],
            ),
          ),
          registerButton
        ],
      ),
    );

    Widget backToLogin = Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "Have an account? ",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Color.fromRGBO(255, 255, 255, 0.8),
              fontSize: 14.0,
            ),
          ),
          InkWell(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.of(context).pop();
            },
            child: const Text(
              'Back to Login',
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1.0),
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );

    Widget footer = Container(
      color: primary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            backToLogin,
            Text(widget.versionNumber,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ))
          ],
        ),
      ),
    );
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/login_background.jpeg'),
                  fit: BoxFit.cover))),
      Container(
        decoration: const BoxDecoration(
          color: transparentPrimary,
        ),
      ),
      CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Spacer(flex: 5),
                title,
                Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: registerForm),
                const Spacer(),
                footer
              ],
            ),
          )
        ],
      ),
    ]));
  }
}
