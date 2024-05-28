import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neunews_flutter/Models/User.dart';
import 'package:neunews_flutter/Pages/CreateNews.dart';
import 'package:neunews_flutter/ReusableWidgets/NewsCard.dart';
import 'package:http/http.dart' as http;
import 'package:neunews_flutter/Session.dart';
import 'package:neunews_flutter/Models/Post.dart';

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
      allNews.add(
        NewsCard(
          post: Post.fromJson(post),
          isAdmin: isAdmin,
        ),
      );
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 20, 20),
                        child: Icon(
                          Icons.newspaper,
                          size: 40,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Text(
                          'News',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ],
                  ),
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
