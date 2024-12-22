import 'package:checkapi/controllers/authentication.dart';
import 'package:checkapi/views/register_screen.dart';
import 'package:checkapi/views/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login Page",
                  style: GoogleFonts.poppins(fontSize: size * 0.060)),
              const SizedBox(height: 30),
              InputWidget(
                hintText: "Username",
                obscureText: false,
                controller: _usernameController,
              ),
              const SizedBox(height: 30),
              InputWidget(
                hintText: "Password",
                obscureText: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15)),
                  onPressed: () async {
                    await _authenticationController.login(
                        username: _usernameController.text.trim(),
                        password: _passwordController.text.trim());
                  },
                  child: Obx(() => _authenticationController.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text("Login",
                          style: GoogleFonts.poppins(
                              fontSize: size * 0.040, color: Colors.white)))),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    Get.to(() => RegisterScreen());
                  },
                  child: Text("Register",
                      style: GoogleFonts.poppins(
                          fontSize: size * 0.040, color: Colors.black))),
            ],
          ),
        ),
      ),
    );
  }
}
