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
  // PageTransitionController? _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = PageTransitionController(
  //     initalizePage: 0,
  //     onTranstionChanged: (animation) => {},
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PageTransitionView(
            pages: [
              Container(
                width: size.width * .8,
                height: 400.0,
                color: Colors.red,
              ),
              Container(
                width: size.width * .8,
                height: 400.0,
                color: Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
