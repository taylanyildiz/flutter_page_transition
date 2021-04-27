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
