import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:neunews_flutter/Models/User.dart';
import 'package:neunews_flutter/Pages/CreateClub.dart';
import 'package:neunews_flutter/ReusableWidgets/ClubCard.dart';
import 'package:http/http.dart' as http;
import 'package:neunews_flutter/Models/Club.dart';
import 'package:neunews_flutter/Session.dart';

class Clubs extends StatefulWidget {
  const Clubs({super.key});

  @override
  State<StatefulWidget> createState() => _ClubsState();
}

class _ClubsState extends State<Clubs> {
  List<Club> objectClubs = [];
  var allClubs = <Widget>[];
  var sessionManager = SessionManagerSingleton();
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

  Future<void> _getAllClubs() async {
    var response = await http.get(Uri.parse(
        "http://neunewsapi.us-east-1.elasticbeanstalk.com/api/Clubs/GetAllClubs.php"));
    var clubs = jsonDecode(response.body);

    allClubs = <Widget>[];
    for (var club in clubs) {
      objectClubs.add(
        Club(
          clubInactive: club['club_inactive'].toString(),
          clubName: club['club_name'].toString(),
          clubImage: club['club_image'].toString(),
          clubDescription: club['club_description'].toString(),
          clubId: club['club_id'].toString(),
          clubApproved: club['club_approved'].toString(),
        ),
      );

      allClubs.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ClubCard(
            club: objectClubs.last,
            admin: isAdmin,
          ),
        ),
      );
    }

    if (allClubs.isEmpty) {
      allClubs.add(
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 4),
          child: const Text(
            'No Clubs currently found',
            style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                            Icons.cabin,
                            size: 40,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Text(
                            'Clubs',
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
                    future: _getAllClubs(),
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
                          children: allClubs,
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
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              backgroundColor: Colors.amberAccent,
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateClubPage(),
                  ),
                );
              },
            )
          : null,
    );
  }
}
