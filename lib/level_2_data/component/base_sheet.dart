import 'dart:io';
import 'package:flutter/material.dart';

class SheetBase {
  static Future<T?> showAppSheet<T>({
    required BuildContext context,
    required Widget widget,
    required Color color,
    double radius = 30.0,
    Color barrierColor = const Color(0xa1000000),
    int animationDurationMs = 250,
    bool removeUntilHome = false,
    bool closeOnTap = false,
    required Function onDisposed}) {
    assert(radius > 0.0);
    var route = _AppModelRoute<T>(
        builder: (BuildContext context) {
          return widget;
        },
        color: color,
        radius: radius,
        label: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrier: barrierColor,
        duration: animationDurationMs,
        closeOnTap: closeOnTap,
        onDisposed: onDisposed);
    if (removeUntilHome) {
      //return Navigator.pushAndRemoveUntil<T>(context, route, RouteUtils.withNameLike('/home'));
    }
    return Navigator.push<T>(context, route);
  }
}

class _AppSheetLayout extends SingleChildLayoutDelegate {
  _AppSheetLayout(this.progress);

  late final double progress;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
        minWidth: constraints.maxWidth,
        maxWidth: constraints.maxWidth,
        minHeight: 0.0,
        maxHeight: constraints.maxHeight * 0.6);
    // if (constraints.maxHeight < 667) {
    //   return BoxConstraints(
    //       minWidth: constraints.maxWidth,
    //       maxWidth: constraints.maxWidth,
    //       minHeight: 0.0,
    //       maxHeight: constraints.maxHeight * 0.95);
    // }
    // if ((constraints.maxHeight / constraints.maxWidth > 2.1 &&
    //     Platform.isAndroid) ||
    //     constraints.maxHeight > 812) {
    //   return BoxConstraints(
    //       minWidth: constraints.maxWidth,
    //       maxWidth: constraints.maxWidth,
    //       minHeight: 0.0,
    //       maxHeight: constraints.maxHeight * 0.8);
    // } else {
    //   return BoxConstraints(
    //       minWidth: constraints.maxWidth,
    //       maxWidth: constraints.maxWidth,
    //       minHeight: 0.0,
    //       maxHeight: constraints.maxHeight * 0.9);
    // }
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(0.0, size.height - childSize.height * progress);
  }

  @override
  bool shouldRelayout(_AppSheetLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}

class _AppModelRoute<T> extends PopupRoute<T> {
  _AppModelRoute({
    required this.builder,
    required this.color,
    required this.barrier,
    required this.label,
    required this.duration,
    required this.radius,
    required this.closeOnTap,
    required this.onDisposed,
    RouteSettings? settings
  }) : super(settings: settings);

  final WidgetBuilder builder;
  final Color barrier;
  final Color color;
  final String label;
  final int duration;
  final double radius;
  final bool closeOnTap;
  final Function onDisposed;

  // late AnimationController _animationController;
  // late CurvedAnimation _appSheetAnimation;

  // 弹出层暗背景的颜色
  @override
  Color? get barrierColor => barrier;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => label;

  // 动画变化的持续时长
  @override
  Duration get transitionDuration => Duration(milliseconds: duration);

  // @override
  // AnimationController createAnimationController() {
  //   _animationController = BottomSheet.createAnimationController(navigator.overlay);
  //   _animationController.duration = Duration(milliseconds: duration);
  //   _appSheetAnimation = CurvedAnimation(
  //       parent: _animationController,
  //       curve: Curves.easeOut,
  //       reverseCurve: Curves.linear)
  //     ..addStatusListener((animationStatus) {
  //       if (animationStatus == AnimationStatus.completed) {
  //         _appSheetAnimation.curve = Curves.linear;
  //       }
  //     });
  //   return _animationController;
  // }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: GestureDetector(
        onTap: () {
          if (closeOnTap) {
            // Close when tapped anywhere
            Navigator.of(context).pop();
          }
        },
        child: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: AnimatedBuilder(
            animation: animation, //_appSheetAnimation,
            builder: (BuildContext context, Widget? child) {
              return CustomSingleChildLayout(
                delegate: _AppSheetLayout(animation.value), //_appSheetAnimation.value
                child: BottomSheet(
                  // animationController: _animationController,
                  onClosing: () => Navigator.pop(context),
                  builder: (context) => Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radius),
                        topRight: Radius.circular(radius),
                      ),
                    ),
                    child: Builder(builder: builder),
                  ),
                )
              );
            }
          )
        )
      )
    );
  }
}