import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_packaging/register.dart';
import 'package:flutter_packaging/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    try {
      Response response = await Dio().post(
        'http://127.0.0.1:8000/api/login',
        data: {
          'email': emailController.text,
          'password': passwordController.text,
        },
      );
      print(response.data);
    } catch (e) {
      print(e);
    }
        Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => const User()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              "images/logo.png",
              fit: BoxFit.fill,
              height: 200,
              width: 200,
            ),
            TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email')),
            TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: const Text('Login'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const RegisterPage()));
                },
                child: const Text('New to App Register')),
          ],
        ),
      ),
    );
  }
}
