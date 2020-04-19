import 'package:flutter/material.dart';

enum Urgency{
  AZ,
  ORTA,
  COK
}

extension UrgencyExtension on Urgency{

  String get value{
    return this.toString().split(".")[1];
  }

  Color get color{
    if(this == Urgency.AZ){
      return Color(0xff40a832);
    }
    if(this == Urgency.ORTA){
      return Color(0xffe7ed3e);
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