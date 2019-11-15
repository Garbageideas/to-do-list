import 'package:flutter/material.dart';
import 'package:to_do_list/overview/theme.dart';
import 'package:to_do_list/overview/routes.dart';


class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ProtoTheme.red,
      child: FlatButton(
        child: Text('Settings'),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}