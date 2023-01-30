import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final Widget body;
  final Axis scrollDirection;
  final bool showAppBar;

  const BaseScaffold({Key? key, required this.body, this.scrollDirection = Axis.horizontal, this.showAppBar = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      appBar: showAppBar ? AppBar(title: const Text("HomeView test")) : null,
      body: SingleChildScrollView(scrollDirection: scrollDirection, child: body),
    );
  }
}
