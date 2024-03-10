import 'package:flutter/material.dart';
import 'global_widgets.dart';
import 'classes/building.dart';

//Main HomePage for App
class BuildingList extends StatefulWidget {
  const BuildingList({super.key});

  @override
  State<BuildingList> createState() => _BuildingList();
}

class _BuildingList extends State<BuildingList> {
  final List<Building> buildings = [Building(name: "Alexander Hall", abrv: "ALEX", floors: []),Building(name: "Animal Science", abrv: "ANNU", floors: []),];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        //Marker for the map
        leading: IconButton(
          icon: const Icon(Icons.map),
          onPressed: () {
            print("Marker clicked!");
          },
        ),
        //Profile for User
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              print("User clicked!");
            },
          ),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: buildings.length,
            prototypeItem: ListTile(
              title: Text("Buildings"),
            ),
            itemBuilder: (context, index) {
              return Padding(padding: EdgeInsets.all(10), child:ListTile(
                title: ElevatedButton(
                    onPressed: ()=>{},
                    child:
                        Align(  alignment: Alignment.centerLeft, child: Text(buildings[index].abrv + "-" + buildings[index].name))
                ),
              )
              );
            },
          )
      ),
    );

  }
}




