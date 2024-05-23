import 'package:flutter/material.dart';
import 'package:aplikasi/page/component/sidebar.dart';
import 'package:aplikasi/page/component/topbar.dart';

void main() {
  runApp(const MaterialApp(
    home: CreateStaffAccountView(),
  ));
}

class CreateStaffAccountView extends StatefulWidget {
  const CreateStaffAccountView({Key? key}) : super(key: key);

  @override
  State<CreateStaffAccountView> createState() => _CreateStaffAccountViewState();
}

class _CreateStaffAccountViewState extends State<CreateStaffAccountView> {
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
      drawer: Sidebar(),
      appBar: TopBar(context, title: "Create Staff Account"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Create Staff Account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
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
          ),
        ),
      ),
    );
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
