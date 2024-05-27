import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatefulWidget {
  final String postTitle;
  final String postImage;
  final String postDescription;
  final String postTime;
  final String postLocation;

  const NewsCard({
    super.key,
    required this.postTitle,
    required this.postImage,
    required this.postDescription,
    required this.postTime,
    required this.postLocation
  });

  @override
  State<NewsCard> createState() => _NewsCardState(postTitle, postImage, postDescription, postTime, postLocation);
}

class _NewsCardState extends State<NewsCard> {
  late String post_title;
  late String post_image;
  late String post_description;
  late String post_location;
  late String post_date;

  _NewsCardState(String postTitle, String postImage, String postDescription, String postTime, String postLocation){
     post_title = postTitle;
     post_image = postImage;
     post_description = postDescription;
     post_location = postLocation;
     post_date = postTime;
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child:
            Container(
              width: MediaQuery.of(context).size.width/1.1,
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
                      Center(
                        child:
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child:
                                Text(
                                post_title,
                                style:
                                const TextStyle(
                                  fontSize: 22,
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            )
                      ),
                      Image.network(
                          post_image,
                          height: 250,
                      ),
                      Center(
                          child:
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            child:
                              Text(
                                post_description,
                                style:
                                const TextStyle(
                                    fontSize: 17,
                                ),
                              ),
                          )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child:
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_month,
                                      color: Colors.amber,
                                    ),
                                    Text(
                                        ' $post_date',
                                      style:
                                        const TextStyle(
                                          fontSize: 13
                                        ),
                                    ),
                                  ],
                                )
                          ),
                          Padding(
                              padding: const EdgeInsets.all(10),
                              child:
                              Row(
                                children: [
                                  const Icon(
                                    Icons.pin_drop_rounded,
                                    color: Colors.amber,
                                  ),
                                  Text(
                                      ' $post_location',
                                    style:
                                    const TextStyle(
                                        fontSize: 13
                                    ),
                                  ),
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
