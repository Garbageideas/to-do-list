import 'package:flutter/material.dart';
import 'package:to_do_list/overview/theme.dart';
import 'package:backdrop/backdrop.dart';
import 'package:to_do_list/screens/backdrop/backdrop.dart';
import 'package:to_do_list/screens/setting_screen.dart';
import 'package:to_do_list/screens/timeline_screen.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      title: Text("Backdrop Example"),
      backLayer: Center(
        child: Text("Backpanel"),
      ),
      frontLayer: Center(
        child: Text("Body"),
      ),
    );
  }
}
