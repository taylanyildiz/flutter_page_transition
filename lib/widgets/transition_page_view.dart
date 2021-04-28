import 'package:flutter/material.dart';
import 'widget.dart';

class _TransitionScope extends InheritedWidget {
  const _TransitionScope({
    Key? key,
    required Widget child,
    required this.state,
  }) : super(key: key, child: child);

  final PageTransitonViewState state;

  @override
  bool updateShouldNotify(_TransitionScope oldWidget) =>
      oldWidget.state != state;
}

class PageTransitionController {
  final int? initalizePage;
  final ValueChanged<Animation>? onTranstionChanged;
  Animation? changeAnimation;

  PageTransitionController({
    this.initalizePage,
    this.onTranstionChanged,
  });
}

class PageTransitonView extends StatefulWidget {
  static PageTransitonViewState? of(BuildContext context) {
    final _TransitionScope? scope =
        context.dependOnInheritedWidgetOfExactType<_TransitionScope>();
    return scope?.state;
  }

  @override
  PageTransitonViewState createState() => PageTransitonViewState();
}

class PageTransitonViewState extends State<PageTransitonView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [],
    );
  }
}
