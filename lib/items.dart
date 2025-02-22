import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_packaging/create_item.dart';
import 'package:flutter_packaging/edit_item.dart';
import 'package:flutter_packaging/make_order.dart';
import 'package:flutter_packaging/user.dart';

class ItemsPage extends StatefulWidget {
  @override
  _ItemsPageState createState() => _ItemsPageState( );
}

class _ItemsPageState extends State<ItemsPage> {
  List items = [];
   int? itemId;
    // _ItemsPageState({required this.itemId});


  Future<void> deleteItem(BuildContext context) async {
    try {
      await Dio().delete('http://127.0.0.1:8000/api/items/$itemId');
      Navigator.pop(context);
    } catch (e) {
      print('Delete Failed: $e');
    }
  }

  Future<void> fetchItems() async {
    try {
      Response response = await Dio().get('http://127.0.0.1:8000/api/items');
      setState(() {
        items = response.data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
        leading: BackButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const User())),
        ),
        backgroundColor: Colors.blue,
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const MakeOrder())),
              child: const Text(
                "Make Order",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              )),
          TextButton(
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => const CreateItemPage())),
              child: const Text(
                "Create Item",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              )),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: [
              Text(items[index]['item_name']),
              Text('Price: ${items[index]['price']}'),
              Text('code: ${items[index]['code']}'),
              Row(
                children: [
                  TextButton(
                      onPressed: () {},
                      child: const Text("Show"),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.amber,
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const EditItemPage()));
                      },
                      child: const Text("Edit"),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                      )),
                  TextButton(
                      onPressed: () {
                        deleteItem(context);
                      },
                      child: const Text("Delete"),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                      ))
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
