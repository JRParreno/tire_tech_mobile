import 'package:flutter/material.dart';

class AppConstant {
  static const kMockupHeight = 812;
  static const kMockupWidth = 375;
  static const shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
  );
  static const clientId = 'oOKyNfQxOKjKCLT8j3iZCAXwn0fylJP7O5oXbLei';
  static const clientSecret =
      'mj7LOhuKy8gGPbpMzW5s1QzRWwilSXExJTEemgoYqyU7E5Gsx8IAZLgc8o5Cymt2Uyxk5eEb2wl1pH5TYYZNJSN2gy1t5eD6sExUUeEGAJrfjtIXmoFPFHJKOdobeOHj';
  static const serverUrl = 'http://192.168.1.11:8000';
  static const apiUrl = '$serverUrl/api';
  static const apiUser = '$serverUrl/user';
  static const appName = 'Tire Tech';
  static const googleApiKey = 'AIzaSyBK2zX8K3Jr2fObVaDBLmjN5vpZ-RPNMy8';
}
