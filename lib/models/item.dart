import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/models/urgency.dart';

class Item{

  final String id;
  final String name;
  final Urgency urgency;
  final DocumentReference reference;

  Item({this.id,this.name, this.urgency,this.reference});

  @override
  String toString() {
    return "Item{ name: $name | urgency: $urgency | id: $id  }";
  }

}