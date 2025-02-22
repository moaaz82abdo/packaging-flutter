import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_packaging/make_order.dart';
import 'package:flutter_packaging/update_order.dart';
import 'package:flutter_packaging/user.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List orders = [];

  Future<void> fetchOrders() async {
    try {
      Response response =
          await Dio().get('http://127.0.0.1:8000/api/orders');
      setState(() {
        orders = response.data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        leading: BackButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const User())),
        ),
        backgroundColor: Colors.blue,
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const MakeOrder())),
              child: Text(
                "Make Order",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: [
            Text('ID: ${orders[index]['id'].toString()}'),
            Text('Item code: ${orders[index]['item_code']},'),
            Text('Item name: ${orders[index]['item_name']},'),
            Text('Quantity: ${orders[index]['quantity'].toString()}'),
            Text('Amount: ${orders[index]['amount'].toString()}'),
            Text('Address: ${orders[index]['address']}'),
            Text('Status: ${orders[index]['status']}'),
            Text('Notes: ${orders[index]['notes']}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              textDirection: TextDirection.ltr,
              children: [
              TextButton(
                      onPressed: () {},
                      child: Text("Show"),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.amber,
                      )),
                  TextButton(child: Text("Edit"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateOrderPage(
                                    orderId: orders[index]['id'] as int,
                                    orderData: orders[index] as Map<String, dynamic>)));
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                      )),
                  TextButton(
                      onPressed: () {},
                      child: Text("Delete"),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                      ))
            ],)
                  
            
          ], 
          );
        },
      ),
    );
  }
}
