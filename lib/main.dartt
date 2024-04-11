import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'loading_screen.dart';
import 'connectivity_screen.dart';
import 'random_person_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InternetConnectionChecker(),
    );
  }
}

class InternetConnectionChecker extends StatefulWidget {
  @override
  _InternetConnectionCheckerState createState() =>
      _InternetConnectionCheckerState();
}

class _InternetConnectionCheckerState extends State<InternetConnectionChecker> {
  bool _isLoading = true;
  bool _hasInternet = true;

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
  }

  Future<void> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _hasInternet = false;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _retryConnection() {
    setState(() {
      _isLoading = true;
      _hasInternet = true;
    });
    _checkInternetConnection();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return LoadingScreen();
    }

    if (!_hasInternet) {
      return ConnectivityScreen(
        onRetry: _retryConnection,
      );
    }

    return RandomPersonScreen();
  }
}
