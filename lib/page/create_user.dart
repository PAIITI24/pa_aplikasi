import 'package:aplikasi/page/component/constrainedbox.dart';
import 'package:aplikasi/page/component/titles.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi/page/component/sidebar.dart';
import 'package:aplikasi/page/component/topbar.dart';

void main() {
  runApp(const MaterialApp(
    home: BuatAkunStaffView(),
  ));
}

class BuatAkunStaffView extends StatefulWidget {
  const BuatAkunStaffView({super.key});

  @override
  State<BuatAkunStaffView> createState() => _BuatAkunStaffViewState();
}

class _BuatAkunStaffViewState extends State<BuatAkunStaffView> {
  final _formKey = GlobalKey<FormState>();

  void _createAccount() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
      // Implement your account creation logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Sidebar(),
        appBar: TopBar(context, title: "Create Staff Account"),
        body: Center(
          child: BoxWithMaxWidth(
              maxWidth: 1000,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const H1("Create Staff Account"),
                    Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          children: [
                            _buildNameField(),
                            const SizedBox(height: 20),
                            _buildEmailField(),
                            const SizedBox(height: 20),
                            _buildPasswordField(),
                            const SizedBox(height: 20),
                            _buildConfirmPasswordField(),
                            const SizedBox(height: 40),
                            ElevatedButton(
                              onPressed: _createAccount,
                              child: const Text('Create Account'),
                            ),
                          ],
                        ))
                  ],
                ),
              )),
        ));
  }

  Widget _buildNameField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Name',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Name cannot be empty';
        }
        return null;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email cannot be empty';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(),
      ),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password cannot be empty';
        }
        return null;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Confirm Password',
        border: OutlineInputBorder(),
      ),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Confirm Password cannot be empty';
        }
        return null;
      },
    );
  }
}
