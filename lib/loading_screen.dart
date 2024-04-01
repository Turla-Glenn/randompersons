import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay of 5 seconds before loading the random person data
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/random_person');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add the Image.network widget with the URL of your GIF
              Image.network(
                'https://media.tenor.com/FIzWAbQcjpYAAAAM/loading-splash.gif', // Replace with your GIF URL
                width: 150, // Adjust width as needed
                height: 150, // Adjust height as needed
              ),
            ],
          ),
        ),
      ),
    );
  }
}