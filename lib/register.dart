import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_packaging/login.dart';
import 'package:flutter_packaging/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phone = TextEditingController();

  Future<void> register() async {
    try {
      Response response = await Dio().post(
        'http://127.0.0.1:8000/api/register',
        data: {
          'name': nameController.text,
          'customer_name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'address': addressController.text,
          'phone': phone.text,
        },options: Options(
          
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
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const User()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [
          Column(
                children: [
                  Image.asset(
                    "images/logo.png",
                    fit: BoxFit.fill,
                    height: 150,
                    width: 200,
                  ),
                  TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Name')),
                  TextField(
                      controller: nameController,
                      decoration:
                          const InputDecoration(labelText: 'Customer name')),
                  TextField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email')),
                  TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true),
                  TextField(
                      controller: passwordController,
                      decoration:
                          const InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true),
                  TextField(
                      controller: addressController,
                      decoration: const InputDecoration(labelText: 'Address')),
                  TextField(
                      controller: phone,
                      decoration:
                          const InputDecoration(labelText: 'Phone Number')),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: register,
                    child: const Text('Register'),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                    },
                    child: const Text('Already have an account? Login'),
                  ),
                ],
              ),
        ],)
      ),
    );
  }
}
