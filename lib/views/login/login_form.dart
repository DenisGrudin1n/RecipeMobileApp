import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipeapp/constants/constants.dart';
import 'package:recipeapp/services/auth_methods.dart';
import 'package:recipeapp/views/entrypoint.dart';
import 'package:recipeapp/views/login/signup_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'Success') {
      Get.offAll(const MainScreen());
    } else {
      setState(() {
        _isLoading = false;
      });
      Get.snackbar('Error', res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
            onPressed: () => loginUser(),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: kDark,
                    ),
                  )
                : const Text(
                    'Login',
                    style: TextStyle(color: kDark),
                  ),
          ),
          const SizedBox(height: 36.0),
          Row(
            children: [
              Text(
                "Don't have an account? ",
                style: TextStyle(color: kWhite.withOpacity(0.25)),
              ),
              GestureDetector(
                onTap: () => Get.to(const SignUpPage()),
                child: const Text(
                  "Sign up",
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
    super.dispose();
  }
}
