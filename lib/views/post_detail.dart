import 'package:checkapi/controllers/post_controller.dart';
import 'package:checkapi/models/post_model.dart';
import 'package:checkapi/views/widgets/input_widget.dart';
import 'package:checkapi/views/widgets/post_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({super.key, required this.post});

  final PostModel post;

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  final TextEditingController _commentController = TextEditingController();
  final PostController _postController = Get.put(PostController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _postController.getComments(widget.post.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(widget.post.user!.name!),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              PostDataWidget(post: widget.post),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                height: 400,
                child: Obx(() => _postController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: _postController.comments.value.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_postController
                                .comments.value[index].user!.name!),
                            subtitle: Text(
                                _postController.comments.value[index].body!),
                          );
                        })),
              ),
              const SizedBox(height: 30),
              InputWidget(
                  hintText: "Tambahkan Komentar Anda",
                  controller: _commentController,
                  obscureText: false),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  await _postController.createComment(
                      widget.post.id, _commentController.text.trim());
                  _commentController.clear();
                  _postController.getComments(widget.post.id);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                ),
                child: const Text(
                  "Tambahkan Komentar",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
