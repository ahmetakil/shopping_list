import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_list/provider/id_controller.dart';
import 'package:shopping_list/repository/firestore_repository.dart';
import 'package:shopping_list/repository/local_storage_repository.dart';
import 'package:shopping_list/screens/settings_screen.dart';
import 'package:shopping_list/util/styles.dart';
import 'package:shopping_list/util/ui_helpers.dart';
import 'package:shopping_list/widgets/join_list_dialog.dart';

import 'list_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> cachedList = [];
  IdController _controller;

  Future<void> createNewListAndForward() async {
    String id = await FirestoreRepository.createNewList();

    _controller.setId(id);
    await LocalStorageRepository.setListId(id);

    navigator.pushReplacement(MaterialPageRoute(
      builder: (_) => ListScreen(),
    ));
  }

  void update() {
    cachedList = LocalStorageRepository.fetchCacheLists();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller = Get.put<IdController>(IdController());
    cachedList = LocalStorageRepository.fetchCacheLists();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: WHITE,
        body: Stack(
          children: [
            Positioned(
              top: 2,
              right: 0,
              child: IconButton(
                icon: Icon(Icons.settings),
                onPressed: () => Get.off(SettingsScreen()),
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
                            text: "Your".tr + " ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                  text: "Lists".tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  )),
                            ]),
                      ),
                    ],
                  ),
                  verticalSpaceSmall,
                  Divider(
                    color: GREEN,
                    thickness: 4,
                  ),
                  verticalSpaceMedium,
                  Expanded(
                    child: ListView.builder(
                      itemCount: cachedList.length,
                      itemBuilder: (_, i) => CachedListTile(
                        id: cachedList[i],
                        index: i + 1,
                        update: update,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _Button(
                        color: GREEN,
                        label: 'create_list',
                        onPressed: () async {
                          await createNewListAndForward();
                        },
                      ),
                      _Button(
                        color: RED,
                        label: 'join_list',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => JoinDialog(),
                          );
                        },
                      ),
                    ],
                  ),
                  verticalSpaceMedium,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final String label;
  final Color color;
  final Function onPressed;

  const _Button({Key key, this.label, this.color, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 3,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(label.tr, style: TextStyle(color: Colors.white)),
        onPressed: onPressed,
      ),
    );
  }
}

class CachedListTile extends StatelessWidget {
  final String id;
  final int index;
  final Function update;

  const CachedListTile({Key key, this.id, this.index, this.update}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Get.find<IdController>().setId(id);
        await LocalStorageRepository.setListId(id);

        navigator.pushReplacement(MaterialPageRoute(
          builder: (_) => ListScreen(),
        ));
      },
      child: Container(
          height: 50,
          margin: EdgeInsets.only(bottom: 10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "$index.List:",
                  style: TextStyle(
                    color: ORANGE,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                horizontalSpaceMedium,
                Text(
                  "$id",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: RED,
                  ),
                  onPressed: () async {
                    await LocalStorageRepository.removeFromCache(id);
                    update();
                  },
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(9)),
              border: Border.all(color: const Color(0x59abb4bd), width: 0.5),
              boxShadow: [BoxShadow(color: const Color(0x10000000), offset: Offset(0, 5), blurRadius: 25, spreadRadius: 0)],
              color: const Color(0xffffffff))),
    );
  }
}
