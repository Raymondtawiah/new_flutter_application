import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pro ID Authentication')),
      body: const Center(child: Text('Authenticate with Pro ID')),
    );
  }
}
