import 'package:flutter/material.dart';
import 'package:flutter_splash/flutter_splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_list/provider/id_provider.dart';
import 'package:shopping_list/screens/choose_screen.dart';
import 'package:shopping_list/screens/list_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> checkListId() async {
    SharedPreferences instance = await SharedPreferences.getInstance();

    if (!instance.containsKey("list")) {
      return Future.delayed(Duration(seconds: 1), () => ChooseScreen());
    }

    String listId = instance.getString("list");
    Provider.of<IdProvider>(context, listen: false).setId(listId);

    return Future.delayed(Duration(seconds: 1), () => ListScreen());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Splash(
      navigateAfterFuture: () => checkListId(),
      backgroundColor: Colors.blueAccent,
      loaderColor: Colors.orangeAccent,
      title: Text(
        "Shopping List",
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}
