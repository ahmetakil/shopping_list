import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_list/provider/id_provider.dart';
import 'package:shopping_list/util/firestore_operations.dart';

import 'list_screen.dart';

class ChooseScreen extends StatefulWidget {
  @override
  _ChooseScreenState createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  final _idController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void createNewListAndForward(BuildContext context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    String id = await FirestoreOperations.createNewList();

    Provider.of<IdProvider>(context, listen: false).setId(id);
    await sp.setString("list", id);

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => ListScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Shopping List"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.lightGreen,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 10),
                            child: Text(
                              "I'm new and I want to create a new list",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                "Create New List",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                createNewListAndForward(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.orangeAccent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 10),
                            child: Text("I already have a list ",
                                style: TextStyle(fontSize: 20)),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                "Join a List",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () => showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  title: Text("Enter List ID"),
                                  content: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller: _idController,
                                          decoration: InputDecoration(
                                            labelText: "List ID",
                                          ),
                                          onSubmitted: (_) =>
                                              FocusScope.of(context).unfocus(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    FlatButton(
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                    RaisedButton(
                                      color: Colors.green,
                                      child: Text("Submit"),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      onPressed: () async {
                                        final String givenId =
                                            _idController.text;

                                        if (!await FirestoreOperations
                                            .canFetchList(givenId)) {
                                          _scaffoldKey.currentState
                                              .removeCurrentSnackBar();
                                          _scaffoldKey.currentState
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                "Lütfen Geçerli Bir ID Girin"),
                                            duration: Duration(seconds: 2),
                                          ));
                                          return;
                                        }

                                        Provider.of<IdProvider>(context,
                                                listen: false)
                                            .setId(givenId);
                                       final sp = await SharedPreferences.getInstance();
                                       sp.setString("list", givenId);
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (_) => ListScreen()));
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
