import 'package:flutter/material.dart';
import 'package:neunews_flutter/upcoming_events.dart';

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
                Text("What's Neu?",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                UpcomingEvents(
                    "Unplug and Play",
                    "Meet in Commons",
                    "August 12th",
                    "https://cdn.discordapp.com/attachments/1052548567325224993/1241628668040708127/image.png?ex=664b8d0e&is=664a3b8e&hm=a3535294e2d947ba95e0218e455f449b44ec49c5300719c67582907877973ba1&"),
                UpcomingEvents("Finger Painting", "Room 208", "May 3rd",
                    "https://media.discordapp.net/attachments/1052548567325224993/1240416307438948392/image.png?ex=664bc135&is=664a6fb5&hm=86e42eb5651e247bbdbd39a9a9c03dc3aa4a6b6957f648bb2532b1e7e1e34a59&=&format=webp&quality=lossless&width=391&height=525"),
                UpcomingEvents("Chow Before the Oww", "Commons", "May 27th",
                    "https://media.discordapp.net/attachments/1052548567325224993/1221872121282564198/image.png?ex=664b8717&is=664a3597&hm=d8480670436ab580d529edeeebaddd14bdcbda8efd04fb161961aabd3b70b92c&=&format=webp&quality=lossless&width=957&height=714"),
                UpcomingEvents("Chow Before the Oww", "Commons", "May 27th",
                    "https://media.discordapp.net/attachments/1052548567325224993/1221872121282564198/image.png?ex=664b8717&is=664a3597&hm=d8480670436ab580d529edeeebaddd14bdcbda8efd04fb161961aabd3b70b92c&=&format=webp&quality=lossless&width=957&height=714"),
                UpcomingEvents("Chow Before the Oww", "Commons", "May 27th",
                    "https://media.discordapp.net/attachments/1052548567325224993/1221872121282564198/image.png?ex=664b8717&is=664a3597&hm=d8480670436ab580d529edeeebaddd14bdcbda8efd04fb161961aabd3b70b92c&=&format=webp&quality=lossless&width=957&height=714"),
                UpcomingEvents("Chow Before the Oww", "Commons", "May 27th",
                    "https://media.discordapp.net/attachments/1052548567325224993/1221872121282564198/image.png?ex=664b8717&is=664a3597&hm=d8480670436ab580d529edeeebaddd14bdcbda8efd04fb161961aabd3b70b92c&=&format=webp&quality=lossless&width=957&height=714"),
                UpcomingEvents("Chow Before the Oww", "Commons", "May 27th",
                    "https://media.discordapp.net/attachments/1052548567325224993/1221872121282564198/image.png?ex=664b8717&is=664a3597&hm=d8480670436ab580d529edeeebaddd14bdcbda8efd04fb161961aabd3b70b92c&=&format=webp&quality=lossless&width=957&height=714"),
                UpcomingEvents("Chow Before the Oww", "Commons", "May 27th",
                    "https://media.discordapp.net/attachments/1052548567325224993/1221872121282564198/image.png?ex=664b8717&is=664a3597&hm=d8480670436ab580d529edeeebaddd14bdcbda8efd04fb161961aabd3b70b92c&=&format=webp&quality=lossless&width=957&height=714"),
                UpcomingEvents("Chow Before the Oww", "Commons", "May 27th",
                    "https://media.discordapp.net/attachments/1052548567325224993/1221872121282564198/image.png?ex=664b8717&is=664a3597&hm=d8480670436ab580d529edeeebaddd14bdcbda8efd04fb161961aabd3b70b92c&=&format=webp&quality=lossless&width=957&height=714"),
                UpcomingEvents("Chow Before the Oww", "Commons", "May 27th",
                    "https://media.discordapp.net/attachments/1052548567325224993/1221872121282564198/image.png?ex=664b8717&is=664a3597&hm=d8480670436ab580d529edeeebaddd14bdcbda8efd04fb161961aabd3b70b92c&=&format=webp&quality=lossless&width=957&height=714"),
                UpcomingEvents("Chow Before the Oww", "Commons", "May 27th",
                    "https://media.discordapp.net/attachments/1052548567325224993/1221872121282564198/image.png?ex=664b8717&is=664a3597&hm=d8480670436ab580d529edeeebaddd14bdcbda8efd04fb161961aabd3b70b92c&=&format=webp&quality=lossless&width=957&height=714"),
                UpcomingEvents("Chow Before the Oww", "Commons", "May 27th",
                    "https://media.discordapp.net/attachments/1052548567325224993/1221872121282564198/image.png?ex=664b8717&is=664a3597&hm=d8480670436ab580d529edeeebaddd14bdcbda8efd04fb161961aabd3b70b92c&=&format=webp&quality=lossless&width=957&height=714"),
                UpcomingEvents("Chow Before the Oww", "Commons", "May 27th",
                    "https://media.discordapp.net/attachments/1052548567325224993/1221872121282564198/image.png?ex=664b8717&is=664a3597&hm=d8480670436ab580d529edeeebaddd14bdcbda8efd04fb161961aabd3b70b92c&=&format=webp&quality=lossless&width=957&height=714"),
              ],
            ),
          )),
    );
  }
}
