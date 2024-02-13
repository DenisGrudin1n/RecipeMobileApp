import 'package:flutter/material.dart';
import 'package:recipeapp/constants/constants.dart';
import 'package:recipeapp/views/login/signup_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kPrimary,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Recipe App',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: kWhite,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              SignUpForm(),
            ],
          ),
        ),
      ),
    );
  }
}
