import 'package:flutter/material.dart';
import 'package:flutter_packaging/items.dart';
import 'package:flutter_packaging/orders.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("Welcome"),),
      body: Center(child: Text("You are logged in"),),
      drawer: Drawer(
  // Add a ListView to the drawer. This ensures the user can scroll
  // through the options in the drawer if there isn't enough vertical
  // space to fit everything.
  child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: [
      const DrawerHeader(
        decoration: BoxDecoration(color: Colors.blue),
        child: Text('Drawer Header'),
      ),
      ListTile(
        title: const Text('Orders'),
        onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>  OrdersPage()));

        },
      ),
      ListTile(
        title: const Text('Items'),
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ItemsPage()));
        },
      ),
    ],
  ),
),
    ),);
  }
}