import 'package:flutter/material.dart';
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


  List<Club> clubs = [
    Club(clubInactive: 'false', clubName: 'NeuRobotics', clubImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrrAh6S8lkaeJCeINtdX1oEaEhr3XLZPqLPH6f90L6EA&s', clubDescription: 'Sponsored by Make Salt Lake', clubId: '664a64806eed0', clubApproved: 'true'),
  ];

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


  // Future<void> fetch() async {
  //   var res = await http.get(Uri.parse('http://localhost:2024/api/Clubs/GetAllClubs.php'));
  //   print('jeffery bezos we here printing out the res.body: ');
  //   print(jsonDecode(res.body));
  //   for(var item in jsonDecode(res.body) as List<dynamic>){
  //     print('jeffery b bezos here to report that the current index item is: ');
  //     print(item);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold( body: Align(
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
                      Icon(Icons.cabin),
                      Text(
                        'Clubs',
                        style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 15
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ClubCard(
                club: clubs[0],
                admin: isAdmin,
              ),
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
                builder: (context) => const CreateClubPage()));
      },
    )
        : null,
    );
  }
}
