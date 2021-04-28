import 'package:flutter/material.dart';

/// [TransitionActionType] change page animation
/// which one you need it.
///
/// Default value null if you have aniamtion you can use it.
///
/// [TransitionActionType.circle]
/// [TransitionActionType.shaher]
enum TransitionActionType {
  shaher,
  circle,
}

typedef TransitionActionDelegateBuilder = Widget Function(BuildContext context,
    int index, Animation? animation, TransitionActionType actionType);

///  * [TransitionActionListDelageteBuilder], which is a delegate that uses a builder
///    callback to construct the transition actions.
abstract class TransitionActionDelegate {
  TransitionActionDelegate();

  /// Transition Page builder.
  ///
  /// Returns the child with given index
  Widget build(BuildContext cntext, int index, Animation animation,
      TransitionActionType actionType);

  /// Returns the number of actions this delegate will build
  int get actionCount;
}

class TransitionActionListDelageteBuilder extends TransitionActionDelegate {
  /// Constructor
  TransitionActionListDelageteBuilder({
    required this.pages,
  });

  /// Page lists
  final List<Widget>? pages;

  @override
  int get actionCount => pages?.length ?? 0;

  @override
  Widget build(BuildContext cntext, int index, Animation? animation,
          TransitionActionType actionType) =>
      pages![index];
}

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
  /// current Page showing index
  final int? initalizePage;

  /// Animation change page
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

  void changePage(detail) {}

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [],
    );
  }
}
