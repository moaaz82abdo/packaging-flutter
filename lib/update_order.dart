import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_packaging/orders.dart';

class UpdateOrderPage extends StatefulWidget {
  final int orderId;
  final Map<String, dynamic> orderData;

  UpdateOrderPage({required this.orderId, required this.orderData});

  @override
  _UpdateOrderPageState createState() => _UpdateOrderPageState();
}

class _UpdateOrderPageState extends State<UpdateOrderPage> {
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController itemCodeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    itemNameController.text = widget.orderData['item_name'];
    itemCodeController.text = widget.orderData['item_code'];
    amountController.text = widget.orderData['amount'].toString();
    addressController.text = widget.orderData['address'];
    notesController.text = widget.orderData['notes'];
    quantityController.text = widget.orderData['quantity'].toString();
    statusController.text = widget.orderData['status'];
  }

  Future<void> updateOrder() async {
    try {
      await Dio().put(
          'http://127.0.0.1:8000/api/orders/${widget.orderId}',
          data: {
            'item_name': itemNameController.text,
            'item_code': itemCodeController.text,
            'amount': int.parse(amountController.text),
            'address': addressController.text,
            'notes': notesController.text,
            'quantity': int.parse(quantityController.text),
            'status': statusController.text,
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
    } catch (e) {
      print('Update Failed: $e');
    }
        Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => OrdersPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Order')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: itemCodeController,
                decoration: InputDecoration(labelText: 'Item Code')),
            TextField(
                controller: itemNameController,
                decoration: InputDecoration(labelText: 'Item Name')),
            TextField(
                controller: quantityController,
                decoration: InputDecoration(labelText: 'Quantity')),
            TextField(
                controller: amountController,
                decoration: InputDecoration(labelText: 'Amount')),
            TextField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Adress')),
            TextField(
                controller: statusController,
                decoration: InputDecoration(labelText: 'Status')),
            TextField(
                controller: notesController,
                decoration: InputDecoration(labelText: ' Notes')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: updateOrder, child: Text('Update Order')),
          ],
        ),
      ),
    );
  }
}
