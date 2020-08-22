import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Urgency{
  AZ,
  ORTA,
  COK,
}

extension UrgencyExtension on Urgency{

  int get priority {
    /*
    Returns AZ -> 0
            ORTA -> 1
            COK -> 2,
     */
    return Urgency.values.indexOf(this);
  }

  String get value{
    return this.toString().split(".")[1];
  }

  String get name {
    return this.toString().tr;
  }

  Color get color{
    if(this == Urgency.AZ){
      return Color(0xff40a832);
    }
    if(this == Urgency.ORTA){
      return Color(0xfff5e042);
    }
    if(this == Urgency.COK){
      return Color(0xfff03b1f);
    }
    return Colors.black;
  }

  static Urgency fromLabel(String label){
    for(Urgency u in Urgency.values){
      if(u.value == label){
        return u;
      }
    }
    return null;
  }
}