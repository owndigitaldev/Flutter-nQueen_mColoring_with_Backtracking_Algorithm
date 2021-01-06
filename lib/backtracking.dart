import 'package:backtracking/common/constans.dart';
import 'package:backtracking/page/menu_page.dart';
import 'package:flutter/material.dart';

class Backtracking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kSAppName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MenuPage(),
    );
  }
}
