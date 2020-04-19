import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/models/item.dart';
import 'package:shopping_list/models/urgency.dart';
import 'package:shopping_list/provider/urgency_provider.dart';

import 'itemDialog.dart';
import 'list_item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: UrgencyProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ShoppingList',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => ItemDialog(_scaffoldKey));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Shopping List"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("items").snapshots(),
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
                  return ListView.builder(
                      itemBuilder: (_, index) {
                        final doc = documents[index];
                        Item item = Item(name: doc["name"],urgency: UrgencyExtension.fromLabel(doc["urgency"]));
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
