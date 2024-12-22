import 'package:checkapi/controllers/authentication.dart';
import 'package:checkapi/views/login_screen.dart';
import 'package:checkapi/views/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

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
              Text("Register Page",
                  style: GoogleFonts.poppins(fontSize: size * 0.060)),
              const SizedBox(height: 30),
              InputWidget(
                hintText: "Name",
                obscureText: false,
                controller: _nameController,
              ),
              const SizedBox(height: 30),
              InputWidget(
                hintText: "Username",
                obscureText: false,
                controller: _usernameController,
              ),
              const SizedBox(height: 30),
              InputWidget(
                hintText: "Email",
                obscureText: false,
                controller: _emailController,
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
                    await _authenticationController.register(
                        name: _nameController.text.trim(),
                        username: _usernameController.text.trim(),
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim());
                  },
                  child: Obx(() => _authenticationController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        ))
                      : Text("Register",
                          style: GoogleFonts.poppins(
                              fontSize: size * 0.040, color: Colors.white)))),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    Get.to(() => LoginScreen());
                  },
                  child: Text("Login",
                      style: GoogleFonts.poppins(
                          fontSize: size * 0.040, color: Colors.black))),
            ],
          ),
        ),
      ),
    );
  }
}
