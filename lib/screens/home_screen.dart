import 'package:flutter/material.dart';
import 'package:to_do_list/overview/theme.dart';
import 'package:to_do_list/overview/routes.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ProtoTheme.yellow,
      child: FlatButton(
        child: Text('Garbageideas Inc.'),
        onPressed: () => Navigator.pushNamed(context, ScreenRoutes.inbox),
      ),
    );
  }
}