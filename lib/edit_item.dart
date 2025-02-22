import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_packaging/items.dart';

class EditItemPage extends StatefulWidget {
  const EditItemPage({super.key});

  @override
  _EditItemPageState createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  var item;
  
  final TextEditingController itemnameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  Future<void> _fetchData(id) async {
    try {
      Response response = await Dio().get('http://127.0.0.1:8000/api/items/edit/$id');
      print(response.data);
      setState(() {
        item = response.data;
      });
    } catch (e) {
      print(e);
    }
  }
  
  @override
  void initState() {
    super.initState();
    _fetchData;
    // codeController.text = item['code'];
    // itemnameController.text = item['item_name'];
    // priceController.text = item['price'];
  }


  

  // Future<void> updateItem() async {
  //   try {
  //     Response response = await Dio().put(
  //       'http://127.0.0.1:8000/api/items/6',
  //       data: {
  //         'code': codeController.text,
  //         'item_name': itemnameController.text,
  //         'price': priceController.text,
  //       },
  //       options: Options(
  //         headers: {
  //           'Accept': 'application/json',
  //         },
  //         followRedirects: false,
  //         maxRedirects: 0,
  //         validateStatus: (status) {
  //           return status! < 500;
  //         },
  //       ),
  //     );
  //     print(response.data);
  //   } catch (e) {
  //     print(e);
  //   }
  //   Navigator.of(context)
  //       .pushReplacement(MaterialPageRoute(builder: (context) => ItemsPage()));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Item'),leading: BackButton(onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) =>  ItemsPage())),),),
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
            SizedBox(height: 20),
            
                //  Text(item['item_name']),
                //  Text(item['code']),
                //  Text(item['price']),
              
            SizedBox(height: 20),
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
              onPressed: (){},
              child: const Text('Update Item'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
