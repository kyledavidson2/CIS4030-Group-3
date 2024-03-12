import 'package:flutter/material.dart';
import 'package:group3_4030/classes/floor.dart';
import 'package:group3_4030/room_page.dart';
import 'package:provider/provider.dart';
import 'classes/building.dart';
import 'classes/room.dart';
import 'global_widgets.dart';
import 'add_room.dart';
import 'building_list.dart';
import 'building_page.dart';
import 'reviews.dart';
import 'classes/all_state.dart';

//Main HomePage for App
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              print("User clicked!");
            },
          ),
        ],
      ),
      body: <Widget>[
        Container(
          //Image Placeholder for Maps
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/map.png"),
                  fit: BoxFit.cover,
                ))),
        Padding(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: (Provider.of<AllStates>(context)).buildings.length,
              prototypeItem: ListTile(
                title: Text("Buildings"),
              ),
              itemBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.all(10),
                    child: ListTile(
                      title: ElevatedButton(
                          onPressed: () => {
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) => BuildingPage(
                          building:  (Provider.of<AllStates>(context))
                              .buildings[index])),
                          )
                      },
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text((Provider.of<AllStates>(context))
                                  .buildings[index].abrv +
                                  "-" +
                                  (Provider.of<AllStates>(context))
                                      .buildings[index].name))),
                    ));
              },
            ))
      ][_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      // drawer: Drawer(
      //   child: ListView(padding: EdgeInsets.zero, children: [
      //     const DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Colors.blue,
      //         ),
      //         child: Text(
      //           'Recipe App',
      //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      //         )),
      //     GestureDetector(
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => AddRoom()),
      //           );
      //         },
      //         child: const ListTile(
      //           leading: Icon(Icons.list_alt),
      //           title: Text("Add Room"),
      //         )),
      //     GestureDetector(
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => BuildingList()),
      //           );
      //         },
      //         child: const ListTile(
      //           leading: Icon(Icons.list_alt),
      //           title: Text("Building List"),
      //         )),
      //     GestureDetector(
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) =>
      //                     RoomPage(
      //                       room: Room(
      //                         name: "ALEX 101",
      //                         floor: 1,
      //                         capacity: 20,
      //                         rating: 3,
      //                         numReviews: 2,
      //                         description: "asdf",
      //                       ),
      //                     )),
      //           );
      //         },
      //         child: const ListTile(
      //           leading: Icon(Icons.list_alt),
      //           title: Text("Room Page"),
      //         )),
      //     GestureDetector(
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => ReviewsPage()),
      //           );
      //         },
      //         child: const ListTile(
      //           leading: Icon(Icons.list_alt),
      //           title: Text("Reviews Page"),
      //         )),
      //     GestureDetector(
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) =>
      //                     BuildingPage(
      //                         building: Building(
      //                             name: "Building name",
      //                             abrv: "err",
      //                             floors: [Floor(level: 1, rooms: [Room(
      //                               name: "Room Name",
      //                               floor: 20,
      //                               capacity: 20,
      //                               rating: 1,
      //                               numReviews: 0,
      //                               description: "asdf",
      //                             )
      //                             ])
      //                             ]))),
      //           );
      //         },
      //         child: const ListTile(
      //           leading: Icon(Icons.list_alt),
      //           title: Text("Building Page"),
      //         )),
      //   ]),
      // ),
    );
  }
}
