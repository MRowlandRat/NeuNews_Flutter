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
    return Card(
      elevation: 10,
      shadowColor: Colors.amber,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Expanded(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Image.network(
                          imgUrl,
                          fit: BoxFit.contain,
                          width: MediaQuery.of(context).size.width / 2,
                        )),
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
                    eventName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on_outlined),
                              Text(eventLocation,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal)),
                            ],
                          )),
                          Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Icon(Icons.access_time),
                              Text(eventDate,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal)),
                            ],
                          )),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
