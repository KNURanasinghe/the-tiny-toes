import 'package:flutter/material.dart';
import 'package:imaginary_baby_gallery_app/screens/userScreen.dart';
import 'package:provider/provider.dart';

import '../components/customTextFeild.dart';
import '../provider/authProvider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<LoginScreen> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  void onPressed() async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    if (userNameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      bool isLoggedIn = await loginProvider.login(
        userNameController.text.trim(),
        passwordController.text.trim(),
      );

      if (isLoggedIn) {
        userNameController.clear();
        passwordController.clear();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Userscreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("User name or password is incorrect")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("All fields are required")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Center(
            child: Text(
          "The Tiny Toes",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w900,
          ),
        )),
        const SizedBox(
          height: 100,
        ),
        CustomTextFeild(
          controller: userNameController,
          hintText: "UserName",
          labelText: "UserName",
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTextFeild(
          controller: passwordController,
          hintText: "Password",
          labelText: "Password",
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 200,
          height: 40,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8), // Set desired radius here
                ),
                backgroundColor: const Color.fromARGB(255, 8, 53, 214)),
            child: const Text(
              "Submit",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        )
      ]),
    );
  }
}
