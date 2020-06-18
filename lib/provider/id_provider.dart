import 'package:flutter/material.dart';

class IdProvider with ChangeNotifier {
  String id;

  void setId(String newId) {
    id = newId;
    notifyListeners();
  }
}
