import 'package:flutter/material.dart';
import 'package:neunews_flutter/ReusableWidgets/NewsCard.dart';
import 'package:neunews_flutter/Session.dart';
import 'package:http/http.dart' as http;
import '../Models/Post.dart';
import '../Models/User.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var sessionManager = SessionManagerSingleton();
  bool isAdmin = false;
  List<Widget> upcomingEvents = [];

  @override
  void initState() {
    super.initState();
    fetchAndSetUser();
  }

  Future<void> _setUpcomingEvents() async {
    var response = await http.get(Uri.parse(
        "http://neunewsapi.us-east-1.elasticbeanstalk.com/api/Posts/GetAllPosts.php"));
    var allNews = jsonDecode(response.body);
    for (var p in allNews) {
      if (upcomingEvents.length < 5) {
        upcomingEvents.add(
          NewsCard(
            post: Post.fromJson(p),
            isAdmin: isAdmin,
          ),
        );
      }else{
        break;
      }
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 20, 20),
                        child: Icon(
                          Icons.add_alert,
                          size: 40,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Text(
                          "What's Neu?",
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
                Center(
                  child: FutureBuilder(
                    future: _setUpcomingEvents(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child:
                              Text('An error has occured: ${snapshot.error}'),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const CircularProgressIndicator(
                          color: Colors.amber,
                        );
                      } else {
                        return Column(
                          children: upcomingEvents,
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
