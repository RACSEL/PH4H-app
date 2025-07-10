import 'package:flutter/material.dart';

class NavigationService {

  NavigationService._(); //prevent instantiation

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}