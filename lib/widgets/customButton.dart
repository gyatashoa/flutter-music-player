import 'package:flutter/material.dart';
import 'package:music_player/config/colors.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final Offset offset;
  CustomButton(this.child, {this.offset,this.height,this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: child,
      decoration: BoxDecoration(
          color: WHITE_THEME,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: offset,
                spreadRadius: 2,
                blurRadius: 5)
          ]),
    );
  }
}
