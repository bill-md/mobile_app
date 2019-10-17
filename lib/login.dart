import 'package:bill_md_mobile/constants.dart';
import 'package:flutter/material.dart';
import 'package:dart_notification_center/dart_notification_center.dart';

class LogInView extends StatefulWidget {
  @override
  createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  void tappedLogIn(_) async {
    DartNotificationCenter.post(
      channel: ObserverNotifications.appStateChanged,
      options: AppState.main,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text(
                'Welcome!',
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x1976D2FF),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTapUp: tappedLogIn,
              child: Container(
                decoration: BoxDecoration(
                  color: BMColors.actionableBlue,
                  borderRadius: BorderRadius.circular(7),
                ),
                margin: EdgeInsets.only(top: 24),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 48),
                child: Text(
                  'Log in',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
