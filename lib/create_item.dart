import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_packaging/items.dart';

class CreateItemPage extends StatefulWidget {
  const CreateItemPage({super.key});

  @override
  _CreateItemPageState createState() => _CreateItemPageState();
}

class _CreateItemPageState extends State<CreateItemPage> {
  final TextEditingController itemnameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController codeController = TextEditingController();


  Future<void> createItem() async {
    try {
      Response response = await Dio().post(
        'http://127.0.0.1:8000/api/items',
        data: {
          'code': codeController.text,
          'item_name': itemnameController.text,
          'price': priceController.text,
          
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
        .pushReplacement(MaterialPageRoute(builder: (context) =>  ItemsPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Item')),
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
                controller: itemnameController,
                decoration: const InputDecoration(labelText: 'Item Name')),
            TextField(
                controller: codeController,
                decoration: const InputDecoration(labelText: 'Code')),
            TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price')),
           
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: createItem,
              child: const Text('Create Item'),
            ),
            const SizedBox(height: 20),
            
          ],
        ),
      ),
    );
  }
}
