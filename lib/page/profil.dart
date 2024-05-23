import 'package:aplikasi/page/component/constrainedbox.dart';
import 'package:aplikasi/page/component/sidebar.dart';
import 'package:aplikasi/page/component/titles.dart';
import 'package:aplikasi/page/component/topbar.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _formKey = GlobalKey<FormState>();

  void _logout() {
    // Implement your logout logic here
    print("User logged out"); // Debugging print statement
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    print("Building ProfileView"); // Debugging print statement
    return Scaffold(
        drawer: const Sidebar(),
        appBar: TopBar(context, title: "Profil"),
        body: Center(
          child: BoxWithMaxWidth(
              maxWidth: 1000,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const H1("User Profile"),
                      Padding(
                        padding: EdgeInsets.all(25),
                        child: Column(children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Nama',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nama tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Kata Sandi Sekarang',
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Kata Sandi Sekarang tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Kata Sandi Baru',
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Kata Sandi Baru tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Konfirmasi Kata Sandi Baru',
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Konfirmasi Kata Sandi Baru tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Processing Data')),
                                    );
                                  }
                                },
                                child: const Text('Submit'),
                              ),
                              const SizedBox(width: 20),
                              ElevatedButton(
                                onPressed: _logout,
                                child: const Text('Logout'),
                              )
                            ],
                          )
                        ]),
                      )
                    ],
                  ),
                ),
              )),
        ));
  }
}

void main() {
  runApp(const MaterialApp(
    home: ProfileView(),
  ));
}
