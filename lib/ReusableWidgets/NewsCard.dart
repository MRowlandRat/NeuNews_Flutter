import 'package:flutter/cupertino.dart';

class NewsCard extends StatefulWidget {
  final int newsId;

  const NewsCard({super.key, required this.newsId});

  @override
  State<NewsCard> createState() => _NewsCardState(newsId);
}

class _NewsCardState extends State<NewsCard> {
  late int news_id;

  _NewsCardState(int newsId){
     news_id = newsId;
  }

  void _getNews(){
    //grab from the api the news via id

  }

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
