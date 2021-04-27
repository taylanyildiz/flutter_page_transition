import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  HomeScreen({
    Key? key,
    required this.title,
  }) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
