import 'package:flutter/material.dart';
import 'package:to_do_list/overview/theme.dart';

class OrganizerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ProtoTheme.green,
      child: FlatButton(
        child: Text('Organizing Desk'),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}