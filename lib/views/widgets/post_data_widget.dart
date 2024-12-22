import 'package:checkapi/controllers/post_controller.dart';
import 'package:checkapi/models/post_model.dart';
import 'package:checkapi/views/post_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PostDataWidget extends StatefulWidget {
  const PostDataWidget({super.key, required this.post});

  final PostModel post;

  @override
  State<PostDataWidget> createState() => _PostDataWidgetState();
}

class _PostDataWidgetState extends State<PostDataWidget> {
  final PostController _postController = Get.put(PostController());
  bool likedPost = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.post.user!.name!,
              style: GoogleFonts.poppins(fontSize: 16)),
          Text(widget.post.user!.email!,
              style: GoogleFonts.poppins(fontSize: 10)),
          const SizedBox(height: 5),
          Text(widget.post.content!),
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    await _postController.likeAndDislike(widget.post.id);
                    _postController.getAllPosts();
                  },
                  icon: Icon(
                    Icons.thumb_up,
                    color: widget.post.liked! ? Colors.blue : Colors.black,
                  )),
              IconButton(
                  onPressed: () {
                    Get.to(() => PostDetail(post: widget.post));
                  },
                  icon: const Icon(Icons.message)),
            ],
          )
        ],
      ),
    );
  }
}
