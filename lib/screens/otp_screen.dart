import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:test_commerce/ext/validation.dart';
import 'package:test_commerce/screens/login_screen.dart';
import 'package:test_commerce/screens/main_screen.dart';

import '../styles/colors.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.account});

  final String account;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late Timer _timer;
  late String _title;
  final int _start = 60;
  final String _resend = "Resend";
  String countdown = "";
  String otpCode = "";

  void startTimer(int start) {
    setState(() {
      countdown = "01:00";
    });
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          setState(() {
            timer.cancel();
            countdown = "Resend";
          });
        } else {
          setState(() {
            start--;
            if (start >= 60) {
              countdown = "01:00";
            } else if (start >= 10) {
              countdown = "00:$start";
            } else {
              countdown = "00:0$start";
            }
          });
        }
      },
    );
  }

  void validateOtp() {
    if (otpCode.length == 5) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainScreen()));
    } else {
      var message =
          otpCode.isEmpty ? "Please enter OTP code" : "Wrong OTP Code";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("$message $otpCode"),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _title = widget.account.isNumeric
        ? 'Confirm OTP sent to your phone number at ${widget.account}'
        : 'Confirm OTP sent to your email at ${widget.account}';
    if (widget.account.isNumeric) {}
    startTimer(_start);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget backButton = Positioned(
      top: 28,
      child: IconButton(
        color: Colors.white,
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false);
        },
      ),
    );

    Widget title = Padding(
        padding: const EdgeInsets.only(
            right: 56.0, bottom: 10.0, top: 56.0, left: 16.0),
        child: Text(
          _title,
          style: const TextStyle(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
        ));

    Widget confirmButton = Positioned(
      left: MediaQuery.of(context).size.width / 2.1,
      bottom: 10,
      child: InkWell(
        onTap: () {
          validateOtp();
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
              child: Text("Confirm",
                  style: TextStyle(
                      color: Color(0xfffefefe),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 18.0))),
        ),
      ),
    );

    Widget otpForm = SizedBox(
      height: 180,
      child: Stack(
        children: <Widget>[
          Container(
            height: 140,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 16.0),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: OtpTextField(
                    numberOfFields: 5,
                    borderColor: primary,
                    cursorColor: primary,
                    enabledBorderColor: primary,
                    showFieldAsBox: true,
                    //runs when a code is typed in
                    onCodeChanged: (String code) {

                    },
                    //runs when every textfield is filled
                    onSubmit: (String verificationCode) {
                      setState(() {
                        otpCode = verificationCode;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          confirmButton
        ],
      ),
    );

    Widget backToLogin = Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "Didn't receive the OTP Code? ",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Color.fromRGBO(255, 255, 255, 0.8),
              fontSize: 14.0,
            ),
          ),
          InkWell(
            onTap: () {
              countdown == _resend ? startTimer(60) : null;
            },
            child: Text(
              countdown,
              style: const TextStyle(
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
      child: Padding(padding: const EdgeInsets.all(8.0), child: backToLogin),
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
                    child: otpForm),
                const Spacer(),
                footer
              ],
            ),
          )
        ],
      ),
      backButton
    ]));
  }
}
