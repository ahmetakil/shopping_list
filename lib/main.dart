import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/provider/id_provider.dart';
import 'package:shopping_list/provider/urgency_provider.dart';
import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UrgencyProvider()),
        ChangeNotifierProvider(create: (_) => IdProvider()),
      ],
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
