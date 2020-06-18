import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_list/provider/id_provider.dart';
import 'package:shopping_list/screens/choose_screen.dart';
import 'package:shopping_list/widgets/item_dialog.dart';
import 'package:shopping_list/widgets/list_item.dart';

import '../models/item.dart';
import '../models/urgency.dart';

class ListScreen extends StatefulWidget {

  const ListScreen({Key key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {

    final String listId = Provider.of<IdProvider>(context).id;

    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) =>
                  ItemDialog(_scaffoldKey.currentState, listId));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Shopping List ~ ${listId}"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              showDialog(context: context,builder: (_) => AlertDialog(
                title: Text("Confirm Changing Lists",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22
                ),),
                content: Container(
                  height: MediaQuery.of(context).size.height*0.25,
                  child: Column(

                    children: [
                      Text("You are about to change your shopping list.")
                    ],
                  ),
                ),
                actions: [
                  FlatButton(
                    child: Text("Cancel",style: TextStyle(color: Colors.red),),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  RaisedButton(
                    color: Colors.green,
                    child: Text("Confirm",style: TextStyle(color: Colors.white),),
                    onPressed: () async{
                      setState(() {
                        loading = true;
                      });
                      final sp = await SharedPreferences.getInstance();
                      await sp.clear();
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (_) => ChooseScreen()
                      ));
                    },
                  )
                ],
              ));
            },
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("list/$listId/items").snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error");
                  }
                  if (!snapshot.hasData) {
                    return Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  final documents = snapshot.data.documents;

                  if (documents == null || documents.length == 0) {
                    return Center(
                      child: Text("Empty List Start Adding Items!",style: TextStyle(fontSize: 24),),
                    );
                  }
                  return ListView.builder(
                      itemBuilder: (_, index) {
                        final doc = documents[index];
                        Item item = Item(
                            id: doc.documentID,
                            name: doc["name"],
                            urgency:
                                UrgencyExtension.fromLabel(doc["urgency"]));
                        return Dismissible(
                          key: ValueKey("${doc["name"]}"),
                          onDismissed: (_) {
                            doc.reference.delete();
                          },
                          child: ListItem(item),
                        );
                      },
                      itemCount: documents.length);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
