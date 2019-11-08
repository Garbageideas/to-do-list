// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';

// copied from vanilla archtecture example
class ProtoTheme {
  static get theme {
    final originalTextTheme = ThemeData.light().textTheme;
    final originalBody1 = originalTextTheme.body1;

    return ThemeData.light().copyWith(
        primaryColor: Colors.indigo[800],
        accentColor: Colors.indigoAccent[300],
        buttonColor: Colors.indigo[800],
        textSelectionColor: Colors.cyan[100],
        backgroundColor: Colors.white,
        toggleableActiveColor: Colors.blueAccent[300],
        floatingActionButtonTheme: FloatingActionButtonThemeData (
//          foregroundColor: Colors.black,
          backgroundColor: Colors.indigo,
        ),
        textTheme: originalTextTheme.copyWith(
            body1:
                originalBody1.copyWith(decorationColor: Colors.transparent)));
  }
}
