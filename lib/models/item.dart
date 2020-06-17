import 'package:shopping_list/models/urgency.dart';

class Item{

  final String id;
  final String name;
  final Urgency urgency;

  Item({this.id,this.name, this.urgency});


  @override
  String toString() {
    return "Item{ name: $name | urgency: $urgency | id: $id  }";
  }

}