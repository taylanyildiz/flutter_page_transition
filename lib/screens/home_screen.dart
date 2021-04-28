import 'package:flutter/material.dart';
import 'package:flutter_page_transition/widgets/widget.dart';

class HomeScreen extends StatefulWidget {
  final String? title;
  HomeScreen({
    Key? key,
    this.title,
  }) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageTransitonView(),
        ],
      ),
    );
  }
}
