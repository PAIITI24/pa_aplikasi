import 'package:aplikasi/page/component/titles.dart';
import 'package:aplikasi/page/dashboard.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
              child: Column(
        children: [
          ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 200),
                  child: Column(children: [
                    const H1('Halo! 👋'),
                    const SizedBox(height: 15),
                    const Text(
                        'Silahkan login terlebih dahulu sebelum melanjutkan'),
                    const SizedBox(height: 50),
                    const TextField(
                        decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email_outlined),
                    )),
                    const SizedBox(height: 20),
                    const TextField(
                        decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.password_outlined),
                    )),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          DoLogin(context);
                        },
                        child: Text("Submit"))
                  ]))),
        ],
      ))),
    );
  }

  void DoLogin(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Dashboard()));
  }
}
