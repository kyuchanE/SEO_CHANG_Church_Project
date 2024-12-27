import 'package:flutter/material.dart';

class BibleCategoryWidget extends StatefulWidget {
  @override
  _BibleCategoryWidgetState createState() => _BibleCategoryWidgetState();
}

class _BibleCategoryWidgetState extends State<BibleCategoryWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 55.0,
          left: 15.0,
          right: 15.0,
        ),
        child: SizedBox(
          width: double.infinity, // match_parent
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                ],
              ),
              Container(
                color: Colors.amberAccent,
                child: Text("Bible Screen!!!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}