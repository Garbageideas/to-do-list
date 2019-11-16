import 'package:flutter/material.dart';
import 'package:to_do_list/screens/home_screen.dart';
import 'package:to_do_list/screens/inbox_screen.dart';
import 'package:to_do_list/screens/organizer_screen.dart';
import 'package:to_do_list/screens/review_screen.dart';
import 'package:to_do_list/screens/setting_screen.dart';
import 'package:to_do_list/screens/home_screen_test.dart';


class ScreenRoutes {
  static final home = "/";
  static final inbox = "/inbox";
  static final organizer = "/organizer";
  static final review = "/review";
  static final setting = "/setting";
  static final home2 = "/home2";

  static final initialRoute = home;

  static final Map<String, WidgetBuilder> routes = {
    ScreenRoutes.home: (context) => HomeScreen(),
    ScreenRoutes.inbox: (context) => InboxScreen(),
    ScreenRoutes.organizer: (context) => OrganizerScreen(),
    ScreenRoutes.review: (context) => ReviewScreen(),
    ScreenRoutes.setting: (context) => SettingScreen(),
    ScreenRoutes.home2: (context) => HomePage(),
  };
}

