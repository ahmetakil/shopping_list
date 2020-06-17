import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/provider/urgency_provider.dart';
import 'package:shopping_list/widgets/urgency_list.dart';

import '../models/urgency.dart';

class ItemDialog extends StatefulWidget {
  final ScaffoldState _scaffoldState;

  ItemDialog(this._scaffoldState);

  @override
  _ItemDialogState createState() => _ItemDialogState();
}

class _ItemDialogState extends State<ItemDialog> {
  final TextEditingController _nameController = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Add Item",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Name",
              ),
              onSubmitted: (_) => FocusScope.of(context).unfocus(),
            ),
            UrgencyList(),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Cancel"),
        ),
        RaisedButton(
          child: loading ? CircularProgressIndicator() : Text("Add"),
          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          onPressed: loading
              ? null
              : () async {
                  String name = _nameController.text;
                  Urgency urgency =
                      Provider.of<UrgencyProvider>(context, listen: false)
                              .urgency ??
                          Urgency.AZ;
                  if (_nameController.text.isEmpty ||
                      _nameController.text.length < 1) {
                    widget._scaffoldState.removeCurrentSnackBar();
                    widget._scaffoldState.showSnackBar(SnackBar(
                      content: Text("Lütfen Geçerli Bir İsim Girin"),
                      duration: Duration(seconds: 2),
                    ));
                    return;
                  }

                  // Checking to see that there is already not an item with the same name
                  final QuerySnapshot firestoreItems = await Firestore.instance
                      .collection("items")
                      .where("name", isEqualTo: name)
                      .getDocuments();

                  // Adding an item and not in modify mode (So the length has to be 0)
                  if (firestoreItems.documents.length != 0) {
                    widget._scaffoldState.removeCurrentSnackBar();
                    widget._scaffoldState.showSnackBar(SnackBar(
                      content:
                          Text("Bu isimde bir ürün zaten listede mevcut ! "),
                      duration: Duration(seconds: 2),
                    ));
                    return;
                  }

                  setState(() {
                    loading = true;
                  });

                  final result =
                      await Firestore.instance.collection("items").add({
                    'name': name,
                    'urgency': urgency.value,
                  });
                  setState(() {
                    loading = false;
                  });
                  _nameController.clear();
                  Navigator.of(context).pop();
                },
        )
      ],
    );
  }
}
