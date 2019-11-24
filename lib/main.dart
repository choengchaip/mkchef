import 'package:flutter/material.dart';
import 'package:mkchef/Pages/MainPage.dart';

void main() {
  runApp(MaterialApp(
    title: "mkchef",
    theme: ThemeData(fontFamily: 'mkFont'),
    home: main_page(),
    debugShowCheckedModeBanner: false,
  ));
}
