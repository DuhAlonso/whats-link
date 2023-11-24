import 'package:flutter/material.dart';

class ElevatedButtonDefault extends StatelessWidget {
  const ElevatedButtonDefault(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.size});

  final String title;
  final GestureTapCallback onPressed;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        minimumSize: Size(size.width - 10, 45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      child: Text(title),
    );
  }
}
