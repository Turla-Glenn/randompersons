import 'dart:io';
import 'package:flutter/material.dart';

class ConnectivityScreen extends StatelessWidget {
  final VoidCallback onRetry;

  const ConnectivityScreen({Key? key, required this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AlertDialog(
          title: Text('No Internet Connection'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Call the onRetry callback when the button is pressed
                onRetry();
              },
              child: Text('Retry'),
            ),
            TextButton(
              onPressed: () {
                exit(0);
              },
              child: Text('Exit'),
            ),
          ],
        ),
      ),
    );
  }
}
