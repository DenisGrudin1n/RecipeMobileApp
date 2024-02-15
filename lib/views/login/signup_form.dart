import 'package:flutter/material.dart';
import 'package:recipeapp/constants/constants.dart';
import 'package:recipeapp/services/auth_methods.dart';
import 'package:recipeapp/views/login/login_page.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _usernameController,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              floatingLabelStyle: const TextStyle(color: kWhite),
              hintText: 'Username',
              hintStyle: TextStyle(color: kGray.withOpacity(0.25)),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          TextField(
            controller: _emailController,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              floatingLabelStyle: const TextStyle(color: kWhite),
              hintText: 'Email',
              hintStyle: TextStyle(color: kGray.withOpacity(0.25)),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          TextField(
            controller: _passwordController,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              floatingLabelStyle: const TextStyle(color: kWhite),
              hintText: 'Password',
              hintStyle: TextStyle(color: kGray.withOpacity(0.25)),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            // Handle the login button click here
            onPressed: () async {
              String res = await AuthMethods().signUpUser(
                  username: _usernameController.text,
                  email: _emailController.text,
                  password: _passwordController.text);
              print(res);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text(
              'Sign Up',
              style: TextStyle(color: kDark),
            ),
          ),
          const SizedBox(height: 36.0),
          Row(
            children: [
              Text(
                "Already have an account? ",
                style: TextStyle(color: kWhite.withOpacity(0.25)),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                ),
                child: const Text(
                  "Log in",
                  style: TextStyle(color: kWhite),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose(); // Додали видалення контролера для імені
    super.dispose();
  }
}
