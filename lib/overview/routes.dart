import 'package:flutter/material.dart';
import 'package:to_do_list/screens/home_screen.dart';
import 'package:to_do_list/screens/inbox_screen.dart';
import 'package:to_do_list/screens/organizer_screen.dart';
import 'package:to_do_list/screens/project_screen.dart';
import 'package:to_do_list/screens/timeline_screen.dart';
import 'package:to_do_list/screens/review_screen.dart';
import 'package:to_do_list/screens/setting_screen.dart';
import 'package:to_do_list/screens/test_screen.dart';

class ScreenRoutes {
  static final home = "/";
  static final inbox = "/inbox";
  static final organizer = "/organizer";
  static final project = "/project";
  static final timeline = "/timeline";
  static final review = "/review";
  static final setting = "/setting";
  static final test = "/test";

  static final initialRoute = home;

  static final Map<String, WidgetBuilder> routes = {
    ScreenRoutes.home: (context) => HomeScreen(),
    ScreenRoutes.inbox: (context) => InboxScreen(),
    ScreenRoutes.organizer: (context) => OrganizerScreen(),
    ScreenRoutes.project: (context) => ProjectScreen(),
    ScreenRoutes.timeline: (context) => TimelineScreen(),
    ScreenRoutes.review: (context) => ReviewScreen(),
    ScreenRoutes.setting: (context) => SettingScreen(),
    ScreenRoutes.test: (context) => TestScreen(),
  };
}
