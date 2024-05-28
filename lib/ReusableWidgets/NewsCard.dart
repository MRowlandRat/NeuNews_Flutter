import 'package:flutter/material.dart';
import 'package:neunews_flutter/Models/Post.dart';
import 'package:http/http.dart' as http;
import 'AdminButton.dart';

class NewsCard extends StatefulWidget {
  final Post post;
  final bool isAdmin;

  const NewsCard({super.key, required this.post, required this.isAdmin});

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {

  Future<void> _deleteNews() async {
    setState(() async {
      await http.delete(Uri.parse(
          "http://neunewsapi.us-east-1.elasticbeanstalk.com/api/Posts/DeletePost.php/${widget.post.postId}"));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.amber,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Expanded(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  widget.post.postTitle,
                  style: const TextStyle(
                      fontSize: 22,
                      color: Colors.amber,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Image.network(
              widget.post.postImage,
              height: 250,
            ),
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  widget.post.postDescription,
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        color: Colors.amber,
                      ),
                      Text(
                        widget.post.postTime,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.pin_drop_rounded,
                        color: Colors.amber,
                      ),
                      Text(
                        widget.post.postLocation,
                        style: const TextStyle(fontSize: 13),
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            widget.isAdmin
                ? Align(
              alignment: Alignment.centerRight,
              child: AdminButton(
                label: 'Delete',
                labelColor: Colors.red,
                action: () {
                  _deleteNews();
                },
              ),
            ) : Text('')
          ],
        ),
      ),
    );
  }
}
