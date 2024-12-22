import 'dart:developer';

import 'package:checkapi/controllers/post_controller.dart';
import 'package:checkapi/views/widgets/post_data_widget.dart';
import 'package:checkapi/views/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PostController _postController = Get.put(PostController());
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read("token");
    log("${token}");
    return Scaffold(
        appBar: AppBar(
            title: const Text("Forum Discussion"),
            centerTitle: true,
            backgroundColor: Colors.black),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              PostWidget(
                  hintText: "Ketikan Sesuatu", controller: _textController),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () async {
                    await _postController.createPost(
                        content: _textController.text.trim());
                    _textController.clear();
                    _postController.getAllPosts();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, elevation: 0),
                  child: Obx(() => _postController.isLoading.value
                      ? const CircularProgressIndicator()
                      : Text("Post",
                          style: GoogleFonts.poppins(
                              fontSize: 15, color: Colors.white)))),
              const SizedBox(height: 30),
              Text(
                "Postingan",
                style: GoogleFonts.poppins(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Obx(() {
                return _postController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _postController.posts.value.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PostDataWidget(
                                post: _postController.posts.value[index]),
                          );
                        });
              })
            ]),
          ),
        ));
  }
}
