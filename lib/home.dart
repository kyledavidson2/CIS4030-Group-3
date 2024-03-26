import 'package:flutter/material.dart';
import 'package:group3_4030/classes/floor.dart';
import 'package:group3_4030/room_page.dart';
import 'package:provider/provider.dart';
import 'classes/building.dart';
import 'classes/room.dart';
import 'global_widgets.dart';
import 'add_room.dart';
import 'building_page.dart';
import 'reviews.dart';
import 'classes/all_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'classes/marker.dart';

//Main HomePage for App
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Building> _searchResult = [];
  TextEditingController controller = TextEditingController();



  //Testing Markers

  Set<Marker> test = setMarkers();
  
  //Setting the Coordinates for the Map to focus on the campus
  static const CameraPosition guelphCampus = CameraPosition(
    target: LatLng(43.530950, -80.226416),
    zoom: 14.5,
  );

  void _onItemTapped(int index) {
    changeFocus();
    setState(() {
      _selectedIndex = index;
      
    });
  }

  Widget _buildBuildingsList(List<Building> buildings) {
    return ListView.builder(
      itemCount: buildings.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(0.0),
          child: ListTile(
            title: ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BuildingPage(building:  buildings[index])
                  ),
                )
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("${buildings[index].abrv} - ${buildings[index].name}")
              )
            ),
          ));
      }
    );
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
          width: 300,
          height: 20,
          child: TextField(
            enableInteractiveSelection: false,
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Search',
              icon: Icon(Icons.search),
            ),
            onChanged: onSearchTextChanged,
          ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: changeFocus,
      child: Scaffold(
        appBar: AppBar(
          leading: _buildSearchBox(),
          leadingWidth: 300,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                print("User clicked!");
              },
            ),
          ],
        ),
        body: <Widget>[
          Container(
            //Image Placeholder for Maps
            child: GoogleMap(
                  mapType: MapType.terrain, initialCameraPosition: guelphCampus,
                  markers: test,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: _searchResult.isNotEmpty || controller.text.isNotEmpty
              ? _buildBuildingsList(_searchResult)
              : _buildBuildingsList((Provider.of<AllStates>(context)).buildings)
          )
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
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    (Provider.of<AllStates>(context, listen: false)).buildings.forEach((building) {
      if (building.name.toLowerCase().contains(text.toLowerCase()) ||
          building.abrv.toLowerCase().contains(text.toLowerCase())) {
        _searchResult.add(building);
      } 
    });

    setState(() {});
  }

  void changeFocus(){
    // This allows closing keyboard when tapping outside of a text field
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus &&
        currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}
