import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neunews_flutter/Models/User.dart';
import 'package:neunews_flutter/Pages/CreateNews.dart';
import 'package:neunews_flutter/ReusableWidgets/NewsCard.dart';
import 'package:http/http.dart' as http;
import 'package:neunews_flutter/Session.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  var sessionManager = SessionManagerSingleton();
  var allNews = <Widget>[];
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    fetchAndSetUser();
  }

  Future<void> fetchAndSetUser() async {
    var json = await sessionManager.getSessionValue('user');
    User user = User.fromJson(json);
    if (user.isAdmin == 'true') {
      setState(() {
        isAdmin = true;
      });
    } else {
      setState(() {
        isAdmin = false;
      });
    }
  }

  Future<void> _getAllNews() async {
    var response = await http.get(Uri.parse(
        "http://neunewsapi.us-east-1.elasticbeanstalk.com/api/Posts/GetAllPosts.php"));
    var posts = jsonDecode(response.body);

    allNews = <Widget>[];
    for (var post in posts) {
      allNews.add(NewsCard(
        postTitle: post['post_title'].toString(),
        postDescription: post['post_description'].toString(),
        postImage: post['post_image'].toString(),
        postLocation: post['post_location'],
        postTime: post['post_time'],
      ));
    }

    if (allNews.isEmpty) {
      allNews.add(Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 4),
        child: const Text(
          'There is currently no News',
          style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: const Text(
                "Current News",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.amber,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: FutureBuilder(
                future: _getAllNews(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('An error has occured: ${snapshot.error}'),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                      color: Colors.amber,
                    );
                  } else {
                    return Column(
                      children: allNews,
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              backgroundColor: Colors.amberAccent,
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateNewsPage()));
              },
            )
          : null,
    );
  }
}
