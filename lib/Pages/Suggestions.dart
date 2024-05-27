import 'package:flutter/material.dart';
import 'package:neunews_flutter/Models/Suggestion.dart';
import 'package:neunews_flutter/Models/User.dart';
import 'package:neunews_flutter/Pages/CreateSuggestion.dart';
import 'package:neunews_flutter/ReusableWidgets/SuggestionCard.dart';
import 'package:neunews_flutter/Session.dart';

class Suggestions extends StatefulWidget {
  const Suggestions({super.key});

  @override
  State<StatefulWidget> createState() => _SuggestionsState();
}

class _SuggestionsState extends State<Suggestions> {
  var sessionManager = SessionManagerSingleton();
  bool isAdmin = false;
  List<Suggestion> suggestions = [
    Suggestion(
        suggestionId: '664a6254caf42',
        suggestionTitle: 'Freezing bathroom sinks',
        suggestionDescription:
            'I hate washing my hands in freezing cold water, can we make the water warmer?',
        suggestionInactive: 'false',
        suggestionCompleted: 'false')
  ];

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
                SuggestionCard(suggestion: suggestions[0], admin: isAdmin),
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
