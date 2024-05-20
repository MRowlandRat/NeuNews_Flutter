import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UpcomingEvents extends StatelessWidget {
  const UpcomingEvents(
      this.eventName, this.eventLocation, this.eventDate, this.imgUrl,
      {super.key});

  final String eventName;
  final String eventLocation;
  final String eventDate;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/5),
          child: Center(
            child: Container(
              height: 150,
              width: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.amber),
              child: Column(
                children: [
                  Image.network(
                    imgUrl,
                    height: 100,
                    width: 300,
                    fit: BoxFit.fill,
                  ),
                  Row(
                    children: [
                      Text(eventName),
                    ],
                  ),
                  Row(
                    children: [
                      Text(eventLocation),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(eventDate)
                    ],
                  )
                ],
              ),
            ),
          ))
    ]);
  }
}
