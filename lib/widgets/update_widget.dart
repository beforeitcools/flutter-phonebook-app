import 'package:flutter/material.dart';

class UpdateWidget extends StatefulWidget {
  final dynamic contact;

  const UpdateWidget({
    super.key,
    required this.contact,
  });

  @override
  State<UpdateWidget> createState() => _UpdateWidgetState();
}

class _UpdateWidgetState extends State<UpdateWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}

/*
class UpdateWidget extends StatelessWidget {
  final dynamic contact;

  const UpdateWidget({
    super.key,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.n],
        ),
      ),
    );
  }
}
*/
