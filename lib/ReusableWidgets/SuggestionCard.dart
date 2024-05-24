import 'package:flutter/material.dart';
import 'package:neunews_flutter/Models/Suggestion.dart';
import 'AdminButton.dart';

class SuggestionCard extends StatefulWidget {
  const SuggestionCard(
      {super.key, required this.suggestion, required this.admin});

  final Suggestion suggestion;
  final bool admin;

  @override
  State<StatefulWidget> createState() => _SuggestionCardState();
}

class _SuggestionCardState extends State<SuggestionCard> {
  late Widget titleWidget;
  late Widget descriptionWidget;
  late Widget completedWidget;
  bool completed = false;

  @override
  void initState() {
    super.initState();
    widget.suggestion.suggestionCompleted == 'true'
        ? completed = true
        : completed = false;
    completedWidget = Text(
      completed ? 'Completed' : 'Incomplete',
      style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 18,
          color: completed ? Colors.green : Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.amber,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Expanded(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        widget.suggestion.suggestionTitle,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.amber),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: completedWidget,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Flexible(
                  child: Text(
                    widget.suggestion.suggestionDescription,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            widget.admin
                ? Padding(
                    padding: EdgeInsets.all(15),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AdminButton(
                                label: 'Approve',
                                labelColor: Colors.green,
                                action: () {
                                  print('code for approving a Suggestion');
                                }),
                            AdminButton(
                              label: 'Delete',
                              labelColor: Colors.red,
                              action: () {
                                print('code for deleting Suggestion');
                              },
                            ),
                          ],
                        )),
                  )
                : const Text('')
          ],
        ),
      ),
    );
  }
}
