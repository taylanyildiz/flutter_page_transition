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
  PageTransitionController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageTransitionController(
      initalizePage: 0,
      onTranstionChanged: (animation) => {},
    );
  }

  final _screens = <Widget>[
    PageTransitionAction(
      currentPage: true,
      child: Container(color: Colors.yellow),
      onChangePosition: (page) {},
    ),
    Scaffold(backgroundColor: Colors.red),
    Scaffold(backgroundColor: Colors.orange),
    Scaffold(backgroundColor: Colors.blue),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageTransitonView(
            controller: _controller,
            direction: Axis.horizontal,
            pages: _screens,
          ),
        ],
      ),
    );
  }
}
