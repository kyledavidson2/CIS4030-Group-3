import 'package:flutter/material.dart';
import 'package:group3_4030/home.dart';
import 'package:group3_4030/reviews.dart';
import 'package:provider/provider.dart';
import 'classes/all_state.dart';
import 'classes/building.dart';
import 'global_widgets.dart';
import 'classes/room.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key,  required this.buildingIdx, required this.roomIdx, required this.floorIdx});
  final int  roomIdx;
  final int  floorIdx;
  final int  buildingIdx;


  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  color: const Color.fromARGB(11, 11, 11, 11),
                  //child: const Text("image here")
                  child: PageView(
                    onPageChanged: (int i){},
                    children: [
                      Image.asset(
                       'assets/mins300.jpg',
                        fit: BoxFit.fitWidth,
                      ), 
                      Image.asset(
                       'assets/mins300.jpg',
                        fit: BoxFit.fitWidth,
                      ),
                      Image.asset(
                       'assets/mins300.jpg',
                        fit: BoxFit.fitWidth,
                      ),  
                    ]
                  ),
                  
                        
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Ink(
                    decoration: const ShapeDecoration(
                      color: Colors.lightBlue,
                      shape: CircleBorder(),
                    ),
                    child: IconButton.filled(
                      iconSize: 26,
                      icon: const Icon(Icons.add_a_photo),
                      color: Colors.white,
                      onPressed: (){},
                    ),
                  )
                )
              ]
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "   ${(Provider.of<AllStates>(context, listen: false)).buildings[widget.buildingIdx].floors[widget.floorIdx].rooms[widget.roomIdx].name} ",
                  style: const TextStyle(
                    fontSize: 26,
                  )
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 28),
                    Text(
                      "${(Provider.of<AllStates>(context, listen: true)).buildings[widget.buildingIdx].floors[widget.floorIdx].rooms[widget.roomIdx].rating.toStringAsFixed(2)}  ",
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
                    onPressed: (){
                      print((Provider.of<AllStates>(context, listen: false)).buildings[widget.buildingIdx].name);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage()
                        ),
                      );
                    } //go to map
                  ),
                  const VerticalDivider(width: 20, color: Colors.transparent),
                  TextButton.icon(
                    icon: const Icon(Icons.star),
                    label: Text("Reviews (${(Provider.of<AllStates>(context, listen: true)).buildings[widget.buildingIdx].floors[widget.floorIdx].rooms[widget.roomIdx].numReviews})", style: const TextStyle(fontSize: 16, decoration: TextDecoration.underline)),
                    onPressed: (){

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ReviewsPage(
                                  buildingIdx: widget.buildingIdx,
                                  roomIdx: widget.roomIdx,
                                  floorIdx: widget.floorIdx,
                                )),
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
                    " Floor: ${(Provider.of<AllStates>(context, listen: false)).buildings[widget.buildingIdx].floors[widget.floorIdx].rooms[widget.roomIdx].floor.toString()}",
                    style: const TextStyle(
                      fontSize: 18,
                    )
                  ),
                  Text(
                    " Number of Seats: ${(Provider.of<AllStates>(context, listen: false)).buildings[widget.buildingIdx].floors[widget.floorIdx].rooms[widget.roomIdx].capacity.toString()}",
                    style: const TextStyle(
                      fontSize: 18,
                    )
                  ),
                  Text(
                    " Description: ${(Provider.of<AllStates>(context, listen: false)).buildings[widget.buildingIdx].floors[widget.floorIdx].rooms[widget.roomIdx].description.toString()}",
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
