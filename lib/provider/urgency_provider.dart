import 'package:flutter/material.dart';
import 'package:shopping_list/models/urgency.dart';

class UrgencyProvider with ChangeNotifier{


  Urgency _urgency;

  Urgency get urgency{
    return _urgency;
  }

  void setUrgency(Urgency newValue){
    _urgency = newValue;
    notifyListeners();
  }

  bool isSelectedUrgency(Urgency urgency){
    return _urgency == urgency;
  }

}