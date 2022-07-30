import 'package:flutter/material.dart';
import 'package:flany/rules.dart';

class BouncyPageRoute extends PageRouteBuilder {
  final Widget widget;

  BouncyPageRoute({required this.widget})
      : super(
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation,
                Widget child) {
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.elasticOut);

              return ScaleTransition(
                scale: animation,
                child: child,
                alignment: Alignment.bottomCenter,
              );
            },
            transitionDuration: const Duration(milliseconds: 450),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secAnimation) {
              return const Rules(
                title: 'Zasady',
              );
            });
}
