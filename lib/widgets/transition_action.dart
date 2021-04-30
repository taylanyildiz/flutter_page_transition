import 'package:flutter/material.dart';
import 'widget.dart';

abstract class RepleceablePageAction extends StatelessWidget {
  RepleceablePageAction({
    Key? key,
    this.direction = Axis.horizontal,
    this.currentPage = false,
  }) : super(key: key);

  /// Display current screen
  ///
  /// Default false
  final bool currentPage;

  /// Gesturedector Drag update offset need
  ///
  /// Default [Axis] horizontal
  final Axis direction;

  /// Every screen widget have position and can be change
  /// show current page
  ///
  /// Change poisiton with gesture <=> position [Offset] Horizontal change position
  late final ValueChanged? onChangePosition;

  /// Calls [onChangePosition] if not null and change the [TransitionPage]
  /// that encloses the given context
  /// this position  [DragUpdateDetails] change our showing page horizontal

  /// Calls [onChangePosition] if not null and change the [TransitionPage]
  /// that encloses the given context
  /// this position  [DragUpdateDetails] change our showing page horizontal
  void _handleChangePosition(BuildContext context, detail) {
    onChangePosition?.call(detail);
    PageTransitonView.of(context)!.changePage(detail);
  }

  /// If the [Axis] is horziontal return true
  bool get directionIsAxis => direction == Axis.horizontal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (detail) => _handleChangePosition(context, detail),
      onPanEnd: (detail) => _handleChangePosition(context, detail),
      onPanDown: (detail) => _handleChangePosition(context, detail),
      child: buildAction(context),
    );
  }

  @protected
  Widget buildAction(BuildContext context);
}

class PageTransitionAction extends RepleceablePageAction {
  /// Constructor [PageTransitionAction] child [PageTransitonView]
  PageTransitionAction({
    Key? key,
    required this.child,
    bool currentPage = false,
  }) : super(
          key: key,
          currentPage: currentPage,
        );

  final Widget child;

  @override
  Widget buildAction(BuildContext context) => child;
}
