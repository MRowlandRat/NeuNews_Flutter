import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  void _getNewsPost(){
    //grab from the api the news via news_id
    

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child:
            Container(
              width: MediaQuery.of(context).size.width/1.2,
              decoration:
              BoxDecoration(
                  color: Colors.white,
                  borderRadius:BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(.2),
                        spreadRadius: 3,
                        blurRadius: 4.5,
                        offset: const Offset(3,3)
                    )
                  ]
              ),
              child:
                  Column(
                    children: [
                      const Center(
                        child:
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child:
                                Text(
                                'Blowing Up Puppies',
                                style:
                                TextStyle(
                                  fontSize: 22,
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            )
                      ),
                      Image.network(
                          'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2023/02/23142013/Alaskan-Malamute-puppy-laying-down-outdoors.jpg',
                          height: 230,
                      ),
                      const Center(
                          child:
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            child:
                              Text(
                                'Join us in the extinction of 30 newborn puppies with C4! It will blow you away!',
                                style:
                                TextStyle(
                                    fontSize: 17,
                                ),
                              ),
                          )
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child:
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      color: Colors.amber,
                                    ),
                                    Text(' Friday 10/22/24'),
                                  ],
                                )
                          ),
                          Padding(
                              padding: EdgeInsets.all(10),
                              child:
                              Row(
                                children: [
                                  Icon(
                                    Icons.pin_drop_rounded,
                                    color: Colors.amber,
                                  ),
                                  Text(' Commons'),
                                ],
                              )
                          ),
                        ],
                      )
                    ],
                  )
            ),
          )
    );
  }
}
