import 'package:flutter/material.dart';

const bool _kCloseOnTap = true;

abstract class ClosableSlideAction extends StatelessWidget {
  final Color? color;
  final VoidCallback? onTap;
  final bool closeOnTap;

  const ClosableSlideAction({
    Key? key,
    this.color,
    this.onTap,
    this.closeOnTap = _kCloseOnTap,
  }) : super(key: key);

  void _handleCloseAfterTap(BuildContext context) {
    onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Material(
        color: color,
        child: InkWell(
          onTap: !closeOnTap ? onTap : () => _handleCloseAfterTap(context),
          child: buildAction(context),
        ),
      ),
    );
  }

  @protected
  Widget buildAction(BuildContext context);
}

class IconSlideAction extends ClosableSlideAction {
  @override
  Widget buildAction(BuildContext context) {
    return Container();
  }
}

class SlideAction extends ClosableSlideAction {
  final IconData? icon;
  final Widget? iconWidget;
  final String? caption;
  final Color? foregroundColor;

  SlideAction({
    Key? key,
    this.icon,
    this.iconWidget,
    this.caption,
    this.foregroundColor,
    Color? color,
    VoidCallback? onTap,
    bool closeOnTap = _kCloseOnTap,
  })  : assert(
          icon != null || iconWidget != null,
          'Either set icon or iconWidget',
        ),
        super(
          key: key,
          color: color ?? foregroundColor,
          onTap: onTap,
          closeOnTap: closeOnTap,
        );

  @override
  Widget buildAction(BuildContext context) {
    final Color estimatedColor =
        ThemeData.estimateBrightnessForColor(color!) == Brightness.light
            ? Colors.black
            : Colors.white;
    final widgets = <Widget>[];
    if (icon != null) {
      Flexible(
        child: Icon(
          icon,
          color: foregroundColor ?? estimatedColor,
        ),
      );
    }
    if (iconWidget != null) {
      widgets.add(
        Flexible(child: iconWidget!),
      );
    }
    if (caption != null) {
      widgets.add(
        Flexible(
          child: Text(
            caption!,
            style: Theme.of(context)
                .primaryTextTheme
                .caption!
                .copyWith(color: foregroundColor ?? estimatedColor),
          ),
        ),
      );
    }
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: widgets,
      ),
    );
  }
}
