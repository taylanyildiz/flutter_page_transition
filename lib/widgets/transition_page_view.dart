import 'dart:async';

import 'widget.dart';
import 'package:flutter/material.dart';

enum TransitionRenderingMode {
  none,
  slide,
  dismiss,
  resize,
}

enum TransitionActionType {
  primary,
  secondary,
}

typedef DismissTransitionActionCallback = void Function(
    TransitionActionType? actionType);

typedef TransitionActionCallback = FutureOr<bool> Function(
    TransitionActionType? actionType);

typedef TransitionActionBuilder = Widget Function(BuildContext context,
    int index, Animation? animation, TransitionRenderingMode step);

abstract class TransitionActionDelegate {
  const TransitionActionDelegate();

  Widget build(BuildContext context, int index, Animation? animation,
      TransitionRenderingMode step);

  int get actionCount;
}

class TransitionActionBuilderDelegate extends TransitionActionDelegate {
  TransitionActionBuilderDelegate({
    required this.actionCount,
    required this.builder,
  });

  final TransitionActionBuilder builder;

  @override
  final int actionCount;

  @override
  Widget build(BuildContext context, int index, Animation? animation,
          TransitionRenderingMode step) =>
      builder(context, index, animation, step);
}

class TransitionActionListDelegate extends TransitionActionDelegate {
  TransitionActionListDelegate({
    required this.actions,
  });

  final List<Widget>? actions;

  @override
  int get actionCount => actions!.length;

  @override
  Widget build(BuildContext context, int index, Animation? animation,
          TransitionRenderingMode step) =>
      actions![index];
}

class _TransitionScope extends InheritedWidget {
  _TransitionScope({
    Key? key,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  /// final TransitionState state;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}

class TransitionData extends InheritedWidget {
  TransitionData({
    Key? key,
    required this.actionType,
    required this.renderingMode,
    required this.totalActionExtend,
    required this.dismissThreshold,
    required this.dismissible,
    required this.actionDelegate,
    required this.overallMoveAnimation,
    required this.actioneExtentRadio,
    required this.direction,
    required Widget child,
  }) : super(key: key, child: child);

  final TransitionActionType? actionType;
  final TransitionRenderingMode renderingMode;
  final double totalActionExtend;
  final double dismissThreshold;
  final bool dismissible;
  final TransitionActionDelegate? actionDelegate;
  final Animation overallMoveAnimation;

  /// final TransionPage transition;
  final double actioneExtentRadio;
  final Axis direction;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    throw UnimplementedError();
  }

  static TransitionData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TransitionData>();
  }
}
