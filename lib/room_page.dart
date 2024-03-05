import 'package:flutter/material.dart';

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
          title: Text(room.name),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 200,
              child: Text("image here")
            ),
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
                  )
                ),
              ],
            ),
            SizedBox(
              height: 250,
              child: NestedTabBar(room: room),
            )
            
          ]
        ),
    );
  }
}

class NestedTabBar extends StatefulWidget {
  const NestedTabBar({super.key, required this.room});

  final Room room;

  @override
  State<NestedTabBar> createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener((){
      print('index: '+ _tabController.index.toString());
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Room room = widget.room;
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: "Overview"),
              Tab(text: "Reviews"),
            ]
          ),
        ),
        SizedBox(
          height: 200,
          child: TabBarView(
            controller: _tabController,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Floor: ${room.floor.toString()}",
                    style: const TextStyle(
                      fontSize: 18,
                    )
                  ),
                  Text(
                    "Capacity: ${room.capacity.toString()}",
                    style: const TextStyle(
                      fontSize: 18,
                    )
                  ),
                  Text(
                    "Description: ${room.description.toString()}",
                    style: const TextStyle(
                      fontSize: 18,
                    )
                  ),
                ],
              ),
              const Center(
                child: Text("It's rainy here"),
              ),
            ]
          ),
        ),
      ],
    );
  }
}