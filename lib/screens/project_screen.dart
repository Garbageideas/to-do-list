import 'package:flutter/material.dart';
import 'package:to_do_list/overview/theme.dart';

class ProjectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ProtoTheme.green,
      child: FlatButton(
        child: Text('ProjectScreen'),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}