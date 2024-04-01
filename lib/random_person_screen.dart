import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:random/connectivity_screen.dart';
import 'package:random/loading_screen.dart';

class RandomPersonScreen extends StatefulWidget {
  @override
  _RandomPersonScreenState createState() => _RandomPersonScreenState();
}

class _RandomPersonScreenState extends State<RandomPersonScreen> {
  Map<String, dynamic>? _randomPerson;
  bool _connectionLost = false;

  @override
  void initState() {
    super.initState();
    // Add a delay of 5 seconds before loading the random person data
    Future.delayed(Duration(seconds: 5), () {
      _loadRandomPerson();
    });
  }

  Future<void> _loadRandomPerson() async {
    try {
      final response = await http.get(Uri.parse("https://api.randomuser.me/"));
      if (response.statusCode == 200) {
        setState(() {
          _randomPerson = json.decode(response.body)["results"][0];
          _connectionLost = false; // Reset connection status if data is successfully loaded
        });
      } else {
        throw Exception("Failed to load random person");
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        _connectionLost = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !_connectionLost;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Random Person'),
          centerTitle: true,
        ),
        body: _connectionLost
            ? ConnectivityScreen(
          onRetry: _loadRandomPerson,
        )
            : SingleChildScrollView(
          child: Stack(
            children: [
              _randomPerson == null
                  ? LoadingScreen()
                  : _buildRandomPersonScreen(),
              if (_randomPerson != null) // Conditionally render the FAB
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: FloatingActionButton(
                    onPressed: () {
                      _loadRandomPerson();
                    },
                    child: Icon(Icons.refresh),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRandomPersonScreen() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[200],
        ),
        child: Column(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(_randomPerson?['picture']?['large'] ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              '${_randomPerson?['name']?['first'] ?? ''} ${_randomPerson?['name']?['last'] ?? ''}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildDetailContainer(Icons.location_on, _randomPerson?['location']?['country'] ?? ''),
            SizedBox(height: 10),
            _buildDetailContainer(
              _randomPerson?['gender'] == 'male' ? Icons.male : Icons.female,
              _randomPerson?['gender'] ?? '',
              color: _randomPerson?['gender'] == 'male' ? Colors.blue : Colors.red,
            ),
            SizedBox(height: 10),
            _buildDetailContainer(Icons.email, _randomPerson?['email'] ?? ''),
            SizedBox(height: 10),
            _buildDetailContainer(Icons.person, _randomPerson?['login']?['username'] ?? ''),
            SizedBox(height: 10),
            _buildDetailContainer(Icons.phone, _randomPerson?['phone'] ?? ''),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailContainer(IconData icon, String text, {Color color = Colors.black}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: color,
          ),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}