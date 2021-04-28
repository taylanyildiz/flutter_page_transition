import 'package:flutter/material.dart';

abstract class RepleceablePageAction extends StatelessWidget {
  RepleceablePageAction({
    Key? key,
    this.onChangePosition,
    this.currentPage = false,
  }) : super(key: key);

  /// Display current screen
  ///
  /// Default false
  final bool currentPage;

  /// Every screen widget have position and can be change
  /// show current page
  ///
  /// Change poisiton with gesture <=> position [Offset]
  final ValueChanged? onChangePosition;

  /// Calls [onChangePosition] if not null and change the [TransitionPage]
  /// that encloses the given context
  /// this position  [DragUpdateDetails] change our showing page horizontal position.
  void _handleChangePosition(BuildContext context, DragUpdateDetails position) {
    onChangePosition?.call(position);
  }

  late DragUpdateDetails position;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (detail) => {
        position = detail,
        !currentPage
            ? onChangePosition
            : () => _handleChangePosition(context, position),
      },
      child: buildAction(context),
    );
  }

  @protected
  Widget buildAction(BuildContext context);
}

// ignore: must_be_immutable
class PageAction extends RepleceablePageAction {
  PageAction({
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

// ignore: must_be_immutable
class PageTransitionAction extends RepleceablePageAction {
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
