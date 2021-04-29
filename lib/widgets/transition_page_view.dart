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
}

class TransitionActionListDelageteBuilder extends TransitionActionDelegate {
  /// Constructor
  TransitionActionListDelageteBuilder({
    required this.pages,
  });

  /// Page lists
  final Widget? pages;

  @override
  Widget build(BuildContext cntext, int index, Animation? animation,
          TransitionActionType actionType) =>
      pages!;
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
  /// Constructor PageTransitionController
  PageTransitionController({
    this.initalizePage,
    this.onTranstionChanged,
    this.page,
  });

  /// current Page showing index
  final int? initalizePage;

  /// Animation change page
  final ValueChanged<Animation>? onTranstionChanged;

  /// Number of page
  final int? page;

  Animation? changeAnimation;
}

class PageTransitonView extends StatefulWidget {
  const PageTransitonView({
    Key? key,
    this.direction = Axis.horizontal,
    this.controller,
    this.pages,
  }) : super(key: key);

  /// Page Direction
  ///
  /// Default horizontal.
  final Axis? direction;

  /// TransitionPageController have animation and initialize page for
  ///
  /// animation transition and change page
  /// Have default value for animation and initialize page index
  final PageTransitionController? controller;

  /// Page List
  final List<Widget>? pages;

  static PageTransitonViewState? of(BuildContext context) {
    final _TransitionScope? scope =
        context.dependOnInheritedWidgetOfExactType<_TransitionScope>();
    return scope?.state;
  }

  @override
  PageTransitonViewState createState() => PageTransitonViewState();
}

class PageTransitonViewState extends State<PageTransitonView>
    with TickerProviderStateMixin {
  /// Number of Pages Widget.
  int? pageCount;

  /// Pages Offset position
  Offset position = Offset(0, 0);

  /// Animation Transition Controller
  AnimationController? _transitionAnimationController;

  /// Animation transition Animation
  Animation? _transitonAnimation;

  @override
  void initState() {
    super.initState();
    _transitionAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _transitonAnimation = CurvedAnimation(
      parent: _transitionAnimationController!,
      curve: Interval(0.0, 1.0, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool get direction => widget.direction == Axis.horizontal;

  void changePage(DragUpdateDetails detail) {
    print('detail = $detail');
    setState(() {
      position = detail.globalPosition;
    });
  }

  /// Check Position by use Axis direction.
  Widget _checkPositionWidget(Widget child) {
    ///
    if (direction)
      return _horizontalWidgetChild(child);
    else
      return _verticalWidgetChild(child);
  }

  /// [Axis] direction if Horizontal
  Widget _horizontalWidgetChild(Widget child) {
    return Container();
  }

  /// [Axis] direction if Vertical
  Widget _verticalWidgetChild(Widget child) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return _TransitionScope(
      state: this,
      child: Stack(
        children: [],
      ),
    );
  }
}
