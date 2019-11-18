import 'package:flutter/material.dart';
import 'package:to_do_list/overview/theme.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ProtoTheme.purple,
      child: FlatButton(
        child: Text('TestScreen'),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
