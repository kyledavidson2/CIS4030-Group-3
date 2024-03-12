import 'package:flutter/material.dart';
import 'package:group3_4030/reviews.dart';
import 'global_widgets.dart';
import 'classes/room.dart';

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
              color: const Color.fromARGB(11, 11, 11, 11),
              //child: const Text("image here")
              child: Image.asset(
                'assets/mins300.jpg',
                fit: BoxFit.fitWidth,
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "   ${room.name} ",
                  style: const TextStyle(
                    fontSize: 26,
                  )
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 28),
                    Text(
                      "${room.rating}  ", 
                      style: const TextStyle(
                        fontSize: 26,
                        //decoration: TextDecoration.underline
                      )
                    ),
                  ],
                )
              ],
            ),
            const Divider(),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    icon: const Icon(Icons.location_on),
                    label: const Text("View on Map", style: TextStyle(fontSize: 16, decoration: TextDecoration.underline)),
                    onPressed: (){} //go to map
                  ),
                  const VerticalDivider(width: 20, color: Colors.transparent),
                  TextButton.icon(
                    icon: const Icon(Icons.star),
                    label: Text("Reviews (${room.numReviews})", style: const TextStyle(fontSize: 16, decoration: TextDecoration.underline)),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReviewsPage()),
                      );
                    }
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
                  const Text("Statistics:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
        //bottomNavigationBar: MainNavigationBar(),
    );
  }
}
