import 'package:flutter/material.dart';
import 'package:test_commerce/ext/validation.dart';

import '../styles/colors.dart';
import '../widgets/input_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController account = TextEditingController(text: "");
  String errorAccount = "";

  void accountValidation() {
    var validation = account.text.validateAccount;
    setState(() {
      errorAccount = validation.isEmpty
          ? "Sorry, we could not find your account"
          : validation;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget backButton = Positioned(
      top: 28,
      child: IconButton(
        color: Colors.white,
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );

    Widget title = const Padding(
        padding:
            EdgeInsets.only(right: 56.0, bottom: 10.0, top: 56.0, left: 16.0),
        child: Text(
          'Find your Account',
          style: TextStyle(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
        ));

    Widget nextButton = Positioned(
      left: MediaQuery.of(context).size.width / 2.1,
      bottom: 10,
      child: InkWell(
        onTap: () {
          accountValidation();
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
              child: Text("Next",
                  style: TextStyle(
                      color: Color(0xfffefefe),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 18.0))),
        ),
      ),
    );

    Widget forgotForm = SizedBox(
      height: 180,
      child: Stack(
        children: <Widget>[
          Container(
            height: 140,
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
                      error: errorAccount,
                    )),
              ],
            ),
          ),
          nextButton
        ],
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
                const Spacer(flex: 2),
                title,
                Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: forgotForm),
                const Spacer(flex: 2),
              ],
            ),
          )
        ],
      ),
      backButton
    ]));
  }
}
