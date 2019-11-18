import 'package:flutter/material.dart';
import 'package:to_do_list/overview/theme.dart';

class BackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ProtoTheme.purple,
      child: FlatButton(
        child: Text('BackScreen'),
        onPressed: () => {}, //Navigator.pop(context),
      ),
    );
  }
}
