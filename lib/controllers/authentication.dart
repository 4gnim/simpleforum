import 'dart:convert';
import 'dart:developer';

import 'package:checkapi/constants/constant.dart';
import 'package:checkapi/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AuthenticationController extends GetxController {
  final isLoading = false.obs;
  final token = "".obs;

  final box = GetStorage();

  Future register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'name': name,
        'username': username,
        'email': email,
        'password': password,
      };

      var response = await http.post(
        Uri.parse("${url}register"),
        headers: {
          "Accept": "application/json",
        },
        body: data,
      );

      if (response.statusCode == 201) {
        isLoading.value = false;
        token.value = json.decode(response.body)["token"];
        box.write("token", token.value);
      } else {
        isLoading.value = false;
        Get.snackbar("Error", json.decode(response.body)["message"],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        log("${json.decode(response.body)}");
      }
    } catch (e) {
      isLoading.value = false;
      // log(e.toString());
    }
  }

  Future login({
    required String username,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'username': username,
        'password': password,
      };

      var response = await http.post(
        Uri.parse("${url}login"),
        headers: {
          "Accept": "application/json",
        },
        body: data,
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        token.value = json.decode(response.body)["token"];
        box.write("token", token.value);
        Get.offAll(HomeScreen());
      } else {
        isLoading.value = false;
        Get.snackbar("Error", json.decode(response.body)["message"],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        log("${json.decode(response.body)}");
      }
    } catch (e) {
      isLoading.value = false;
      // log(e.toString());
    }
  }
}
