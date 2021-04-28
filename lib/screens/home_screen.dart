import 'package:flutter/material.dart';
import 'package:flutter_page_transition/widgets/transition_page.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PageTransitionAction(
                onPosition: () => print('hey'),
                child: Container(
                  color: Colors.red,
                  height: 100.0,
                  width: 100.0,
                )),
          ],
        ),
      ),
    );
  }
}
