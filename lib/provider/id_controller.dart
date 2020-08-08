import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IdController extends GetxController {
  String id;

  void setId(String newId) {
    id = newId;
    update();
  }
}
