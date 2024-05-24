import 'package:flutter/material.dart';
import 'package:neunews_flutter/ReusableWidgets/UpcomingEvents.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Align(
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 10)), 
                Text("What's Neu?",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 10)),       
                UpcomingEvents(
                    "Unplug and Play", "Commons", "August 12th",
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Google_2015_logo.svg/1200px-Google_2015_logo.svg.png"),
                Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                UpcomingEvents("Finger Painting", "Room 208", "May 3rd",
                    "https://inasianspaces.com/wp-content/uploads/2023/01/chainsaw-man-ep-6-kobeni-wants-to-kill-denji.png?w=1200"),
                Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                UpcomingEvents("Chow Before the Oww", "Commons", "May 27th",
                    "https://static.wikia.nocookie.net/legendsofthemultiuniverse/images/7/78/1411327022409.jpg/revision/latest?cb=20150516013237"), 
                    ],
            ),
          )),
    );
  }
}
