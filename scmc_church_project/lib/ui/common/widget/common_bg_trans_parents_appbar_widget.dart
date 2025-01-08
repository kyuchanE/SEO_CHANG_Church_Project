import 'package:flutter/material.dart';

typedef OnTapBackCallback = void Function();

/// 배경 투명한 AppBar
Widget bgTransParentsAppbar({
  required OnTapBackCallback onTapBackCallback,
  EdgeInsetsGeometry padding = const EdgeInsets.only(
    top: 60.0,
    left: 15.0,
    right: 15.0,
    bottom: 60.0,
  ),
}) {
  return Padding(
    padding: padding,
    child: SizedBox(
      width: double.infinity, // match_parent
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => onTapBackCallback(),
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
