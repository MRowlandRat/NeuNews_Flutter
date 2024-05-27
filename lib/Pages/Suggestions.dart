import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:neunews_flutter/Models/Suggestion.dart';
import 'package:neunews_flutter/Models/User.dart';
import 'package:neunews_flutter/Pages/CreateSuggestion.dart';
import 'package:neunews_flutter/ReusableWidgets/SuggestionCard.dart';
import 'package:neunews_flutter/Session.dart';
import 'package:http/http.dart' as http;

class Suggestions extends StatefulWidget {
  const Suggestions({super.key});

  @override
  State<StatefulWidget> createState() => _SuggestionsState();
}

class _SuggestionsState extends State<Suggestions> {
  var sessionManager = SessionManagerSingleton();
  bool isAdmin = false;
  var allSuggestions = <Widget>[];
  List<Suggestion> objectSuggestions = [];

  Future<void> _getAllSuggestions() async {
    var response = await http.get(Uri.parse("http://neunewsapi.us-east-1.elasticbeanstalk.com/api/Suggestions/GetAllSuggestions.php"));
    var suggestions = jsonDecode(response.body);

    allSuggestions = <Widget>[];
    for(var suggestion in suggestions){
      objectSuggestions.add(
        Suggestion(
            suggestionId: suggestion['suggestion_id'].toString(),
            suggestionTitle: suggestion['suggestion_title'].toString(),
            suggestionDescription:  suggestion['suggestion_description'].toString(),
            suggestionInactive:  suggestion['suggestion_inactive'].toString(),
            suggestionCompleted:  suggestion['suggestion_completed'].toString()
        )
      );

      allSuggestions.add(
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child:
              SuggestionCard(
                suggestion: objectSuggestions.last,
                admin: isAdmin,
              )
        )

      );
    }

    if(allSuggestions.isEmpty){
      allSuggestions.add(
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 4),
            child:
            const Text(
              'There is currently no Suggestions',
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
                        Icon(Icons.diamond),
                        Text(
                          'Suggestions',
                          style: TextStyle(
                              fontWeight: FontWeight.w100, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                    child:
                    FutureBuilder(
                      future: _getAllSuggestions(),
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
                            children: allSuggestions,
                          );
                        }
                      },
                    )
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
                        builder: (context) => const CreateSuggestionPage()));
              },
            )
          : null,
    );
  }
}
