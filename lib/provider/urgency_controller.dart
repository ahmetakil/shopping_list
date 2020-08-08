import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_list/models/urgency.dart';

class UrgencyController extends GetxController{


  Urgency _urgency;

  Urgency get urgency{
    if(_urgency == null){
      return Urgency.AZ;
    }

    return _urgency;
  }

  void setUrgency(Urgency newValue){
    _urgency = newValue;
    update();
  }

  bool isSelectedUrgency(Urgency urgency){
    return _urgency == urgency;
  }

}