import 'package:flutter/material.dart';

class ChangableTransitionSizeBox extends AnimatedWidget {
  /// Constructor ChangableTransitionSizeBox
  ChangableTransitionSizeBox({
    Key? key,
    required this.animation,
  }) : super(
          key: key,
          listenable: animation,
        );

  /// Animation current page transition change
  final Animation animation;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
