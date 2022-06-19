import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({Key? key, this.child}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
            0,
            0.35,
            0.64,
            0.82,
            1,
          ],
          colors: [
            Color(0xff4588D7),
            Color(0xff82B8E7),
            Color(0xffD7CCC2),
            Color(0xffF1D2B0),
            Color(0xffF5B376),
          ],
        ),
      ),
      child: child,
    );
  }
}
