import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nanoid/async/nanoid.dart';
import 'package:shopping_list/models/urgency.dart';

class FirestoreRepository {
  static Firestore _instance = Firestore.instance;

  static Future<bool> doesItemExists(String ID, String itemName) async {
    QuerySnapshot items = await _instance
        .collection("list/$ID/items")
        .where("name", isEqualTo: itemName)
        .limit(1)
        .getDocuments();

    return items.documents.length != 0;
  }

  static void addNewItem(String ID, String name, Urgency urgency) async {
    await _instance.collection("list/$ID/items").add({
      'name': name,
      'urgency': urgency.value,
    });
  }

  static Future<bool> canFetchList(String ID) async {
    if(ID.isEmpty) {
      return false;
    }
   final doc = await _instance.document("list/$ID").get();

   if(!doc.exists){
     return false;
   }

   return true;
  }

  static Future<void> updateItem(
      String ID, String itemId, String name, Urgency urgency) async{

   try{
     await _instance.collection("list/$ID/items").document(itemId).updateData({
       "name": name,
       "urgency": urgency.value,
     });
   }catch(e){
     print('FirestoreRepository.updateItem: $e');
   }
  }

  static Future<String> createNewList() async {
    String ID = await nanoid(6);
    print("Created ID $ID");

    DocumentSnapshot document = await _instance.document("list/$ID").get();

    while (document.exists) {
      // If ID already exists re-generate the ID and check again

      print("Was not unique creat again to $ID");
      ID = await nanoid(6);
      document = await _instance.document("list/$ID").get();
    }
    /*
  Because firebase does not like empty documents without any fields TODO: Improve this
   */
    final unusedFile =
        await _instance.collection("list").document(ID).setData({
          'created_at': FieldValue.serverTimestamp(),
        });

    final doc = await _instance
        .collection("list/$ID/items")
        .add({'name': 'Welcome', 'urgency': 'COK'});

    print("Add the first item $doc");

    return ID;
  }
}
