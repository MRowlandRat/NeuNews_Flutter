import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neunews_flutter/Pages/CreateNews.dart';
import 'package:neunews_flutter/ReusableWidgets/NewsCard.dart';
import 'package:http/http.dart' as http;

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  var allNews = <Widget>[];

  Future<void> _getAllNews() async {
    var response = await http.get(Uri.parse("http://neunewsapi.us-east-1.elasticbeanstalk.com/api/Posts/GetAllPosts.php"));
    var posts = jsonDecode(response.body);

    allNews = <Widget>[];
    for(var post in posts){
      allNews.add(
        NewsCard(
          postTitle: post['post_title'].toString(),
          postDescription: post['post_description'].toString(),
          postImage: post['post_image'].toString(),
          postLocation: post['post_location'],
          postTime: post['post_time'],
        )
      );
    }

    if(allNews.isEmpty){
      allNews.add(
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 4),
            child:
            const Text(
              'There is currently no News',
              style:
              TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic
              ),
            ),
          )
      );
    }
  }

  void _CreateNewsPage(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CreateNewsPage())
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child:
            Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Current News",
                              style:
                              TextStyle(
                                  fontSize: 30,
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            FloatingActionButton(
                                onPressed: _CreateNewsPage,
                                backgroundColor: Colors.amber,
                                shape: const CircleBorder(),
                                child: const Icon(Icons.add, size: 28)
                            )
                          ],
                        )

                ),
                Center(
                    child:
                    FutureBuilder(
                      future: _getAllNews(),
                      builder: (context, snapshot){
                        if(snapshot.hasError){
                          return Center(
                            child:
                            Text('An error has occured: ${snapshot.error}'),
                          );
                        }else if(snapshot.connectionState == ConnectionState.waiting){
                          return const CircularProgressIndicator(
                            color: Colors.amber,
                          );
                        }else{
                          return Column(
                            children: allNews,
                          );
                        }
                      },
                    )
                )
              ],
            )
    );
  }
}
