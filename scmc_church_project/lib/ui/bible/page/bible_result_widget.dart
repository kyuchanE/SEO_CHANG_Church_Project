import 'package:flutter/material.dart';
import 'package:scmc_church_project/ui/bible/widget/bible_loading_widget.dart';

class BibleResultWidget extends StatefulWidget {
  @override
  _BibleResultWidgetState createState() => _BibleResultWidgetState();
}

class _BibleResultWidgetState extends State<BibleResultWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            isShowBibleLoading(isLoading: true),
          ],
        ),
      ),
    );
  }
}
