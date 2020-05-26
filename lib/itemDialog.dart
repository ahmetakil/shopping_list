import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/provider/urgency_provider.dart';

import 'models/urgency.dart';

class ItemDialog extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final _scaffoldKey;

  ItemDialog(this._scaffoldKey);

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
          child: Text("Add"),
          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          onPressed: () async {
            String name = _nameController.text;
            Urgency urgency =
                Provider.of<UrgencyProvider>(context, listen: false).urgency ?? Urgency.AZ;
            if (_nameController.text.isEmpty ||
                _nameController.text.length < 1) {
              _scaffoldKey.currentState.removeCurrentSnackBar();
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text("Lütfen Geçerli Bir İsim Girin"),
                duration: Duration(seconds: 2),
              ));
              return;
            }
            final result = await Firestore.instance.collection("items").add({
              'name': name,
              'urgency': urgency.value,
            });
            _nameController.clear();
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}

class UrgencyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Aciliyet: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for(Urgency u in Urgency.values)
                UrgencyBox(u)
            ],
          ),
        ],
      ),
    );
  }
}

class UrgencyBox extends StatefulWidget {
  final Urgency urgency;

  UrgencyBox(this.urgency);

  @override
  _UrgencyBoxState createState() => _UrgencyBoxState();
}

class _UrgencyBoxState extends State<UrgencyBox> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final urgencyProvider = Provider.of<UrgencyProvider>(context);

    return InkWell(
      onTap: () {
        Provider.of<UrgencyProvider>(context, listen: false)
            .setUrgency(widget.urgency);
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.urgency.color,
              borderRadius: BorderRadius.circular(6),
            ),
            width: 40,
            height: 40,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            widget.urgency.value,
            style: urgencyProvider.isSelectedUrgency(widget.urgency)
                ? TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold)
                : TextStyle(),
          )
        ],
      ),
    );
  }
}
