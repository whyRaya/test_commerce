import 'package:flutter/material.dart';
import 'package:test_commerce/styles/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with
    SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> opacity;

  @override
  void initState() {
    super.initState();
    var duration = 1200;
    controller = AnimationController(
        duration: Duration(milliseconds: duration),
        vsync: this
    );
    // .. cascade notation
    opacity = Tween<double>(begin: 1.0, end: 0.0)
        .animate(controller)..addListener(() {
          setState(() {});
    });
    TickerFuture tickerFuture = controller.repeat();
    tickerFuture.timeout(Duration(milliseconds: duration * 2), onTimeout: () {
      controller.forward(from: 1).then((value) => () {

      });
      controller.stop(canceled: true);
    });

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: transparentPrimary),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Expanded(child: Opacity(opacity: opacity.value, child: Image.asset('assets/flutter_logo.png')))
            ],
          ),
        ),
      ),
    );
  }
}
