import 'package:flutter/material.dart';

class MyFavorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favorite Page'),
      ),
      body: Center(
        child: Text(
          'This is the My Favorite Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
