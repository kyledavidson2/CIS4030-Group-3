import 'package:flutter/material.dart';
import 'global_widgets.dart';

//move this to a different file
class Room {
  Room({
    required this.name,
    required this.location,
    this.latitude,
    this.longitude,
    required this.floor,
    required this.capacity,
    this.rating = 0,
    this.numReviews = 0,
    this.description = "",
  });

  String name;
  //Building building;
  String location;
  double? latitude;
  double? longitude;
  int floor;
  int capacity;
  double rating;
  int numReviews;
  String description;

  /* Not sure how to implement photos, maybe a list of file paths if they
  are stored locally. Or something else if they are fetched from a
  server. */
}

class RoomPage extends StatefulWidget {
  const RoomPage({super.key, required this.room});
  final Room room;

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {

  @override
  Widget build(BuildContext context) {
    Room room = widget.room;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Color.fromARGB(11, 11, 11, 11),
              child: Text("image here")
            ),
            Divider(),
            Row(
              children: [
                Text(
                  "   ${room.name}                     ",
                  style: const TextStyle(
                    fontSize: 26,
                  )
                ),
                const Icon(Icons.star, color: Colors.amber, size: 28),
                Text(
                  room.rating.toString(), 
                  style: const TextStyle(
                    fontSize: 26,
                    //decoration: TextDecoration.underline
                  )
                ),
              ],
            ),
            Divider(),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    icon: Icon(Icons.location_on),
                    label: Text("View on Map", style: TextStyle(fontSize: 16, decoration: TextDecoration.underline)),
                    onPressed: (){} //go to map
                  ),
                  const VerticalDivider(width: 20, color: Colors.transparent),
                  TextButton.icon(
                    icon: Icon(Icons.star),
                    label: Text("Reviews (${room.numReviews})", style: TextStyle(fontSize: 16, decoration: TextDecoration.underline)),
                    onPressed: (){} //go to map
                  ),
                ]
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Statistics:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(
                    " Floor: ${room.floor.toString()}",
                    style: const TextStyle(
                      fontSize: 18,
                    )
                  ),
                  Text(
                    " Number of Seats: ${room.capacity.toString()}",
                    style: const TextStyle(
                      fontSize: 18,
                    )
                  ),
                  Text(
                    " Description: ${room.description.toString()}",
                    style: const TextStyle(
                      fontSize: 18,
                    )
                  ),
                ],
              ),
            )
            
            
          ]
        ),
        bottomNavigationBar: MainNavigationBar(),
    );
  }
}