import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_page_transition/widgets/widget.dart';

/// [TransitionActionType] change page animation
/// which one you need it.
///
/// Default value null if you have aniamtion you can use it.
///
/// [TransitionActionType.circle]
/// [TransitionActionType.shaher]
enum TransitionActionType {
  none,
  shaher,
  circle,
}

/// Returns build widget child action [TransitionActionDelegateBuilder]
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
    required this.child,
  });

  /// Page lists
  final Widget? child;

  @override
  Widget build(BuildContext cntext, int index, Animation? animation,
          TransitionActionType actionType) =>
      child!;
}

class _TransitionScope extends InheritedWidget {
  const _TransitionScope({
    Key? key,
    required Widget child,
    required this.state,
  }) : super(key: key, child: child);

  final PageTransitionViewState state;

  @override
  bool updateShouldNotify(_TransitionScope oldWidget) =>
      oldWidget.state != state;
}

/// PageTransitionController return [PageTransitionView] animation, pages index.
///
/// Default value have [PageTransitionController]
class PageTransitionController {
  /// Constructor PageTransitionController
  PageTransitionController({
    this.page,
    this.initalizePage,
    this.onTranstionChanged,
  });

  /// current Page showing index
  final int? initalizePage;

  /// Animation change page
  final ValueChanged<Animation>? onTranstionChanged;

  /// Number of page
  final int? page;

  Animation? changeAnimation;
}

class PageTransitionView extends StatefulWidget {
  PageTransitionView({
    Key? key,
    required List<Widget>? pages,
    Axis? direction,
    bool isShow = false,
    PageTransitionController? controller,
    TransitionActionType? actionType,
  }) : this.builder(
          key: key,
          pages: pages,
          isShow: isShow,
          controller: controller,
          actionType: actionType,
          direction: direction,
        );

  /// Constructor PageTransitionView [PageTransitionView.builder]
  const PageTransitionView.builder({
    Key? key,
    required this.pages,
    this.direction = Axis.horizontal,
    this.isShow = true,
    this.controller,
    this.actionType = TransitionActionType.none,
  })  : assert(pages != null),
        super(key: key);

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

  /// Specifies to close this slidable after the closest [PageTransitionView]'s position changed.
  /// If false, the child will not show.
  final bool? isShow;

  /// Transition page animation selected
  final TransitionActionType? actionType;

  /// [_TransitionScope] changable position control.
  static PageTransitionViewState? of(BuildContext context) {
    final _TransitionScope? scope =
        context.dependOnInheritedWidgetOfExactType<_TransitionScope>();
    return scope?.state;
  }

  @override
  PageTransitionViewState createState() => PageTransitionViewState();
}

class PageTransitionViewState extends State<PageTransitionView>
    with TickerProviderStateMixin {
  /// Number of Pages Widget.
  int? pageCount;

  /// Pages Offset position set-get
  Offset position = Offset(0, 0);
  Alignment _dragAlignment = Alignment(0.0, 0.0);

  /// Animation Transition Controller
  AnimationController? _transitionAnimationController;

  /// Animation controller position
  Animation<Alignment>? _positionAnimation;

  /// Animation page transition control
  Animation<Alignment>? _transitionAnimation;

  @override
  void initState() {
    super.initState();
    _transitionAnimationController = AnimationController(vsync: this);
    _transitionAnimationController!.addListener(() {
      setState(() {
        setState(() => _dragAlignment = _positionAnimation!.value);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _transitionAnimationController!.dispose();
  }

  /// If direction is horizontal returns true.
  ///
  /// Default direction is horizontal
  bool get direction => widget.direction == Axis.horizontal;

  /// [GestureDetector] returns values [detail] location position.
  void changePage(detail) {
    if (detail is DragUpdateDetails) {
      setState(() => _dragAlignment += Alignment(detail.delta.dx / 10.0, 0));
    }
    if (detail is DragDownDetails) _transitionAnimationController!.stop();
    if (detail is DragEndDetails) {
      _runAnimation(detail, MediaQuery.of(context).size);
    }
  }

  /// Horizontol position controller clap([-15.0],[+15.0])
  ///
  /// Changing current page
  void _runAnimation(DragEndDetails detail, Size size) {
    final pixelsPerSecond = detail.velocity.pixelsPerSecond;
    print('aling : ${_dragAlignment.x}');
    if ((_dragAlignment.x > -15.0 && _dragAlignment.x < 0) ||
        (_dragAlignment.x > 0 && _dragAlignment.x < 15.0)) {
      _positionAnimation = _transitionAnimationController!.drive(
        AlignmentTween(
          begin: _dragAlignment,
          end: Alignment(0.0, 0.0),
        ),
      );
      final unitsPerSecondX = pixelsPerSecond.dx / size.width;
      final unitsPerSecondY = pixelsPerSecond.dy / size.height;
      final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
      final unitVelocity = unitsPerSecond.distance;

      const spring = SpringDescription(
        mass: 30,
        stiffness: 1,
        damping: 1,
      );

      final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

      _transitionAnimationController!.animateWith(simulation);
    } else {
      if (_dragAlignment.x < 0) {}
    }
  }

  // /// Check TransitionType
  // bool get _actionType => widget.actionType == TransitionActionType.none;

  /// Check Position by use Axis direction.
  Widget _checkPositionWidget(Widget child) {
    if (direction)
      return _horizontalWidgetChild(child);
    else
      return _verticalWidgetChild(child);
  }

  /// [Axis] direction if Horizontal layout.
  Widget _horizontalWidgetChild(Widget child) {
    return Container();
  }

  /// [Axis] direction if Vertical layout.
  Widget _verticalWidgetChild(Widget child) {
    return Container();
  }

  // @override
  // void didUpdateWidget(PageTransitionView oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (widget.isShow != oldWidget.isShow) {}
  // }

  /// Index 0 widget returns [GestureDetector] detail
  ///
  ///
  /// Which page is current page control.
  Widget _listLayout() {
    final content = <Widget>[];
    final p = widget.pages!.length;

    for (var i = 0; i < p; i++) {
      content.add(
        _TransitionScope(
          child: PageTransitionAction(
            alignment: widget.isShow! ? _dragAlignment : null,
            child: widget.pages![i],
          ),
          state: this,
        ),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return _TransitionScope(
      state: this,
      child: Stack(
        children: [
          PageTransitionAction(
            alignment: _dragAlignment,
            child: Container(
              color: Colors.blue,
              width: size.width * .9,
              height: 500.0,
            ),
          ),
          PageTransitionAction(
            alignment: Alignment(_dragAlignment.x + 20.0, 0),
            child: Container(
              color: Colors.red,
              width: size.width * .9,
              height: 500.0,
            ),
          ),
          PageTransitionAction(
            alignment: Alignment(_dragAlignment.x + 40.0, 0),
            child: Container(
              color: Colors.orange,
              width: size.width * .9,
              height: 500.0,
            ),
          ),
        ],
      ),
    );
  }
}
