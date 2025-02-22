import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_packaging/create_item.dart';
import 'package:flutter_packaging/orders.dart';

class MakeOrder extends StatefulWidget {
  const MakeOrder({super.key});

  @override
  _MakeOrderState createState() => _MakeOrderState();
}

class _MakeOrderState extends State<MakeOrder> {
  
  final TextEditingController itemCode = TextEditingController();
  final TextEditingController itemName = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController status = TextEditingController();
  final TextEditingController notes = TextEditingController();

  Future<void> createOrder() async {
    try {
      Response response = await Dio().post(
        'http://127.0.0.1:8000/api/orders',
        data: {
          'user_id': 1,
          'item_code': itemCode.text,
          'item_name': itemName.text,
          'quantity': quantity.text,
          'amount': amount.text,
          'address': address.text,
          'status': status.text,
          'notes': notes.text,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
          followRedirects: false,
          maxRedirects: 0,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      print(response.data);
    } catch (e) {
      print(e);
    }
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => OrdersPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create order'),actions: [TextButton(onPressed: (){
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => CreateItemPage()));
              }, child: Text("Make items first"))],),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              "images/logo.png",
              fit: BoxFit.fill,
              height: 150,
              width: 200,
            ),
            TextField(
              controller: itemCode,
              decoration: const InputDecoration(labelText: 'Item code'),
            ),
            TextField(
              controller: itemName,
              decoration: const InputDecoration(labelText: 'Item name'),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: quantity,
              decoration: const InputDecoration(labelText: 'Quantity'),
            ),
            TextField(
                keyboardType: TextInputType.number,
                controller: amount,
                decoration: const InputDecoration(labelText: 'Amount')),
            TextField(
                controller: address,
                decoration: const InputDecoration(labelText: 'Address')),
            TextField(
                controller: status,
                decoration: const InputDecoration(labelText: 'Status')),
            TextField(
                controller: notes,
                decoration: const InputDecoration(labelText: 'Notes')),
            
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: createOrder,
              child: const Text('Create order'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
