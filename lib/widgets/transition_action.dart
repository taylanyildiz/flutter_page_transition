import 'package:flutter/material.dart';
import 'widget.dart';

abstract class RepleceablePageAction extends StatelessWidget {
  RepleceablePageAction({
    Key? key,
    this.direction = Axis.horizontal,
    this.onChangePosition,
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
  final ValueChanged? onChangePosition;

  /// Calls [onChangePosition] if not null and change the [TransitionPage]
  /// that encloses the given context
  /// this position  [DragUpdateDetails] change our showing page horizontal

  /// Calls [onChangePosition] if not null and change the [TransitionPage]
  /// that encloses the given context
  /// this position  [DragUpdateDetails] change our showing page horizontal
  void _handleChangePosition(BuildContext context, DragUpdateDetails detail) {
    onChangePosition?.call(detail);
    PageTransitonView.of(context)!.changePage(detail);
  }

  /// If the [Axis] is horziontal or vertical
  bool get directionIsAxis => direction == Axis.horizontal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (detail) => !directionIsAxis && currentPage
          ? _handleChangePosition(context, detail)
          : null,
      onHorizontalDragUpdate: (detail) => directionIsAxis && currentPage
          ? _handleChangePosition(context, detail)
          : null,
      child: buildAction(context),
    );
  }

  @protected
  Widget buildAction(BuildContext context);
}

class PageTransitionAction extends RepleceablePageAction {
  PageTransitionAction({
    Key? key,
    required this.child,
    required ValueChanged? onChangePosition,
    bool currentPage = false,
  }) : super(
          onChangePosition: onChangePosition,
          key: key,
          currentPage: currentPage,
        );

  final Widget child;

  @override
  Widget buildAction(BuildContext context) => child;
}
