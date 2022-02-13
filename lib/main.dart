import 'package:flutter/material.dart';
import 'package:whats_link/src/pages/home_page.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Roboto'),
    debugShowCheckedModeBanner: false,
    home: const HomePage(),
  ));
}
