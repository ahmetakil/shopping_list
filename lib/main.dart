import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
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
              builder: (_) => AlertDialog(
                    title: Text(
                      "Add Item",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: "Name",
                          ),
                          onSubmitted: (_) => FocusScope.of(context).unfocus(),
                        ),
                        TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Amount",
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text("Cancel"),
                      ),
                      FlatButton(
                        child: Text("Add"),
                        onPressed: () {
                          print("NAME CONTROLLER -> $_nameController");
                          String name = _nameController.text ?? "A";
                          int amount =
                              int.tryParse(_amountController.text) ?? -1;

                          if (name == "A" ||
                              name == "" ||
                              amount == -1 ||
                              amount < 1) {
                            _scaffoldKey.currentState.removeCurrentSnackBar();
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text("Lütfen Geçerli Değerler Girin"),
                              duration: Duration(seconds: 2),
                            ));
                            return;
                          }
                          Firestore.instance.collection("items").add({
                            'name': name,
                            'amount': amount,
                          }).then((_) {
                            _nameController.clear();
                            _amountController.clear();
                            Navigator.of(context).pop();
                          });
                        },
                      )
                    ],
                  ));
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
                    return CircularProgressIndicator();
                  }
                  final documents = snapshot.data.documents;
                  return ListView.builder(
                      itemBuilder: (_, index) {
                        final doc = documents[index];
                        return Dismissible(
                          key: ValueKey("${doc["name"]}-${doc["amount"]}"),
                          onDismissed: (_) {
                            doc.reference.delete();
                          },
                          child: Container(
                            margin:
                                EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey)),
                            child: ListTile(
                              title: Text(
                                "${doc["name"]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              leading: CircleAvatar(
                                child: Text("${doc["amount"]}x"),
                              ),
                            ),
                          ),
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
