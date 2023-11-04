import 'package:flutter/material.dart';
import 'package:idstask/routes/routes.dart';
import 'package:idstask/utils/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.homeScreen);
          },
          child: Container(
            width: mqw(context, 140),
            height: mqh(context, 50),
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blue)),
            child: const Center(
              child: Text(
                'Login',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
