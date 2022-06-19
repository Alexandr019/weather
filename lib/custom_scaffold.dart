import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold(
      {Key? key, this.needToShowButton = false, this.body, required this.text})
      : super(key: key);
  final bool needToShowButton;
  final Widget? body;
  final String text;

  @override
  Widget build(BuildContext context) {
    InkWell? button;
    if (needToShowButton) {
      button = InkWell(
        onTap: () => Navigator.of(context, rootNavigator: true).pop(),
        child: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          text,
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            letterSpacing: 2,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: button,
      ),
      body: body,
    );
  }
}
