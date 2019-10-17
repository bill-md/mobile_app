library constants;

import 'package:flutter/painting.dart';

enum AppState { auth, main }

class ObserverNotifications {
  static const appStateChanged = "AppState.Changed";
}

class BMColors {
  static final actionableBlue = Color(0xFF47E4BB);
  static final alertOrange = Color(0xFFEC9B3B);
  static final warningRed = Color(0xFFE8647C);
  static final darkGrey = Color(0xFF030303);
  static final grey = Color(0xFF4A4A4A);
  static final lightGrey = Color(0xFFA4A4A4);
  static final backgroundGrey = Color(0xFFF3F3F3);
}

class FirebaseCollections {
  static const user_accounts = 'useraccounts'; 
}

class UIAssets {
  static final boxShadow = [
    BoxShadow(
      blurRadius: 2,
      offset: Offset(0, 3),
      color: Color(0x1A000000),
    )
  ];
}
