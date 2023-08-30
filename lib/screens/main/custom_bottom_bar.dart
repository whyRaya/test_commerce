import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    super.key,
    required this.controller,
  });

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              'assets/google.svg',
              height: 24,
              width: 24,
            ),
            onPressed: () {
              controller.animateTo(0);
            },
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/google.svg',
              height: 24,
              width: 24,
            ),
            onPressed: () {
              controller.animateTo(1);
            },
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/google.svg',
              height: 24,
              width: 24,
            ),
            onPressed: () {
              controller.animateTo(2);
            },
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/google.svg',
              height: 24,
              width: 24,
            ),
            onPressed: () {
              controller.animateTo(3);
            },
          )
        ],
      ),
    );
  }
}
