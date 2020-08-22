import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_list/models/item.dart';
import 'package:shopping_list/models/urgency.dart';
import 'package:shopping_list/provider/id_controller.dart';
import 'package:shopping_list/repository/local_storage_repository.dart';
import 'package:shopping_list/util/styles.dart';
import 'package:shopping_list/util/ui_helpers.dart';
import 'package:shopping_list/widgets/item_dialog.dart';
import 'package:shopping_list/widgets/list_item.dart';

import 'home_screen.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  bool loading = false;

  IdController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<IdController>();
  }

  @override
  Widget build(BuildContext context) {
    String listId = controller.id;
    return SafeArea(
      child: Scaffold(
        backgroundColor: WHITE,
        body: Stack(
          children: [
            Positioned(
              top: 2,
              right: 0,
              child: IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () async {
                  await LocalStorageRepository.clearListId();
                  Get.offAll(HomeScreen());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 45),
              child: Column(
                children: [
                  verticalSpaceSmall,
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                            text: "Shopping ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                  text: "List: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  )),
                            ]),
                      ),
                      Text(
                        listId,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ORANGE,
                        ),
                      ),
                    ],
                  ),
                  verticalSpaceSmall,
                  Divider(
                    color: GREEN,
                    thickness: 4,
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection("list/$listId/items")
                          .snapshots(),
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
                        final List<DocumentSnapshot> documents = snapshot.data.documents;

                        if (documents == null || documents.length == 0) {
                          return Center(
                            child: Text(
                              "empty_screen".tr,
                              style: TextStyle(fontSize: 24),
                            ),
                          );
                        }

                        final List<Item> items = documents.map(
                            (DocumentSnapshot doc) => Item(
                              id: doc.documentID,
                              name: doc["name"],
                              urgency: UrgencyExtension.fromLabel(doc["urgency"]),
                              reference: doc.reference,
                            )
                        ).toList();

                        items.sort( (a,b) => b.urgency.priority.compareTo(a.urgency.priority));


                        return ListView.builder(
                            itemBuilder: (_, index) {
                              Item item = items[index];
                              return Dismissible(
                                key: ValueKey(items[index].name),
                                onDismissed: (_) {
                                  item.reference.delete();
                                },
                                child: ListItem(
                                    item: item,
                                    index: index,
                                    delete: () {
                                      item.reference.delete();
                                    }),
                              );
                            },
                            itemCount: items.length);
                      },
                    ),
                  ),
                  verticalSpaceSmall,
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 50,
                    height: 46,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      color: GOLD,
                      child: Text(
                        'add_new_item'.tr,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (_) => ItemDialog(listId));
                      },
                    ),
                  ),
                  verticalSpaceSmall,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
