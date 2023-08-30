import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:test_commerce/ext/validation.dart';
import 'package:test_commerce/screens/forgot_password_screen.dart';
import 'package:test_commerce/screens/main_screen.dart';
import 'package:test_commerce/screens/register_screen.dart';
import 'package:test_commerce/styles/colors.dart';
import 'package:test_commerce/widgets/input_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController account = TextEditingController(text: "");
  TextEditingController password = TextEditingController(text: "");
  bool passwordVisible = true;
  String appVersion = "";
  String accountError = "";
  String passwordError = "";

  @override
  void initState() {
    super.initState();
    setAppVersion();
  }

  Future<void> setAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    setState(() {
      appVersion = "v.$version";
    });
  }

  void loginValidation() {
    var accountValidation = account.text.validateAccount;
    var passwordValidation = password.text.isPasswordValid;
    setState(() {
      accountError = accountValidation;
      passwordError = passwordValidation;
    });
    if (accountValidation.isEmpty && passwordValidation.isEmpty) {
      navigate(const MainScreen());
    }
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
          'Login to your Account',
          style: TextStyle(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
        ));

    Widget loginButton = Positioned(
      left: MediaQuery.of(context).size.width / 2.1,
      bottom: 10,
      child: InkWell(
        onTap: () {
          loginValidation();
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
              child: Text("Log In",
                  style: TextStyle(
                      color: Color(0xfffefefe),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 18.0))),
        ),
      ),
    );

    Widget loginForm = SizedBox(
      height: 285,
      child: Stack(
        children: <Widget>[
          Container(
            height: 245,
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
                    error: passwordError,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0, top: 10.0),
                  child: InkWell(
                    onTap: () {
                      navigate(const ForgotPasswordScreen());
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color.fromRGBO(225, 95, 40, 1.0),
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          loginButton
        ],
      ),
    );

    Widget separator = Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Row(
        children: [
          Expanded(child: Container(height: 1, color: Colors.white)),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "OR",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Container(height: 1, color: Colors.white))
        ],
      ),
    );

    Widget loginWithGoogle = Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: SizedBox(
        width: double.infinity,
        height: 56.0,
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/google.svg',
            semanticsLabel: 'Google icon',
            height: 24,
            width: 24,
          ),
          label: const Text('Login with Google'), // <-- Text
        ),
      ),
    );

    Widget signUp = Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "Don't have an account? ",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Color.fromRGBO(255, 255, 255, 0.8),
              fontSize: 14.0,
            ),
          ),
          InkWell(
            onTap: () {
              navigate(RegisterScreen(versionNumber: appVersion));
            },
            child: const Text(
              'Sign up',
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
            signUp,
            Text(appVersion,
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
                    child: loginForm),
                separator,
                loginWithGoogle,
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
