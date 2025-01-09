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
  String title = "",
}) {
  return Padding(
    padding: padding,
    child: SizedBox(
      width: double.infinity, // match_parent
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 90,
                right: 90,
              ),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
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
