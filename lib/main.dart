import 'package:bill_md_mobile/constants.dart';
import 'package:bill_md_mobile/login.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:bill_md_mobile/main_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(BillMDApp());

class BillMDApp extends StatefulWidget {
  @override
  State createState() => _BillMDAppState();
}

class _BillMDAppState extends State<BillMDApp> {
  AppState appState;

  @override
  void initState() {
    super.initState();

    appState = AppState.auth;

    DartNotificationCenter.subscribe(
      observer: this,
      channel: ObserverNotifications.appStateChanged,
      onNotification: (options) => setState(() => appState = options),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget view;

    switch (appState) {
      case AppState.auth:
        view = LogInView();
        break;
      case AppState.main:
        view = MainView();
        break;
      default:
        view = null;
        break;
    }

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF1976D2),
        accentColor: Color(0xFFFF1744),
        textTheme: TextTheme(
          body1: TextStyle(
            color: BMColors.darkGrey,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
      home: view,
    );
  }
}
