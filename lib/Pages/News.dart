import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neunews_flutter/ReusableWidgets/NewsCard.dart';
import '../ReusableWidgets/NeuAppBar.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  var allNews = <Widget>[];

  void _getAllNews(){
    //makes call to backend when loading the page
    //map each one of the results to a newsCard object

  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child:
        Column(
          children: allNews,
        ),
    );
  }
}
