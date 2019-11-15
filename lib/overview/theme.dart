// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';

// copied from vanilla archtecture example
class ProtoTheme {

  static const darkBlue = Color(0xff173f5f);
  static const blue = Color(0xff20639b);
  static const green = Color(0xff3caea3);
  static const yellow = Color(0xfff6d55c);
  static const red = Color(0xffed553b);

  static const num elevationLayerOne = 5.0;


  static get theme {
    final originalTextTheme = ThemeData.dark().textTheme;
    final originalBody1 = originalTextTheme.body1;

    return ThemeData.light().copyWith(
        primaryColor: ProtoTheme.darkBlue,
        accentColor: Colors.indigoAccent[300],
        buttonColor: Colors.indigo[800],
        textSelectionColor: ProtoTheme.yellow,
        backgroundColor: Colors.white,
        toggleableActiveColor: ProtoTheme.yellow,
        floatingActionButtonTheme: FloatingActionButtonThemeData (
//          foregroundColor: Colors.black,
          backgroundColor: ProtoTheme.darkBlue,
        ),
        textTheme: originalTextTheme.copyWith(
            body1:
                originalBody1.copyWith(decorationColor: Colors.transparent)));
  }
}
