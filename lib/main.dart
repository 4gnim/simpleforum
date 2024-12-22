import 'views/home_screen.dart';
import 'views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  runApp(SimpleForum());
}

class SimpleForum extends StatelessWidget {
  const SimpleForum({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read("token");
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: token == null ? LoginScreen() : HomeScreen(),
    );
  }
}
