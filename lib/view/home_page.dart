import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Pradip gautam",
              style: TextStyle(fontSize: 30),
            ),
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlSZXmoqGnSkn0nCTzmiO8NzaPDXkgl_HH9w&usqp=CAU"),
            ),
            SignInButton(Buttons.Facebook, text: "Sign Out Facebook", onPressed: () {})
          ],
        ),
      ),
    );
  }
}
