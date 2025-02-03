import 'package:flutter/material.dart';

typedef MainBottomNavClickEvent = void Function();

Widget mainBottomNavigationItem({
  required IconData iconData,
  required MainBottomNavClickEvent onClick,
  required String label,
  required bool isSelected,
}) {
  return Center(
    child: GestureDetector(
      onTap: () => onClick(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Icon(
              size: isSelected ? 40.0 : 25.0,
              iconData,
              color: isSelected ? Colors.black : Colors.black54,
            ),
          ),
          isSelected
              ? Container()
              : Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                )
        ],
      ),
    ),
  );
}
