import 'package:flutter/material.dart';
import 'package:to_do_list/overview/theme.dart';


class ReviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ProtoTheme.blue,
      child: FlatButton(
        child: Text('Reviews'),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}