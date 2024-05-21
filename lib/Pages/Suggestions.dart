import 'package:flutter/material.dart';
import 'package:neunews_flutter/Models/Suggestion.dart';
import 'package:neunews_flutter/ReusableWidgets/SuggestionCard.dart';

class Suggestions extends StatefulWidget {
  const Suggestions({super.key});

  @override
  State<StatefulWidget> createState() => _SuggestionsState();
}

class _SuggestionsState extends State<Suggestions> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Align(
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
              SuggestionCard(suggestion: suggestions[0], admin: true),
            ],
          ),
        ),
      ),
    );
  }
}
