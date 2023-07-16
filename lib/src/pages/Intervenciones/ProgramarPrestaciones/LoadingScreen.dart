import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final String loadingMessage;

  const LoadingScreen({super.key, this.loadingMessage = 'Cargando...'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              Text(
                loadingMessage,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}