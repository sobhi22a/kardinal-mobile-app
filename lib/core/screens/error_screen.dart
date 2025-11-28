import 'package:e_commerce_app/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatelessWidget {
  final Exception? error;

  const ErrorScreen({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(error?.toString() ?? 'Page not found'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRouter.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}

// Navigation helper extension
extension NavigationHelpers on BuildContext {
  // Push new route
  void navigateTo(String route, {Map<String, String>? params}) {
    go(route);
  }

  // Push with replacement
  void replaceTo(String route) {
    pushReplacement(route);
  }

  // Go back
  void goBack() {
    pop();
  }
}