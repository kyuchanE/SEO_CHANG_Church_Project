import 'package:flutter/material.dart';

/// 성경 데이터 로딩 위젯
Widget isShowBibleLoading({bool isLoading = true}) {
  if (isLoading) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white60,
      child: const Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  } else {
    return Container();
  }
}
