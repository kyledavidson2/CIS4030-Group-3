import 'package:flutter/material.dart';
import 'package:group3_4030/add_room.dart';
import 'package:group3_4030/room_page.dart';
import 'classes/room.dart';
import 'classes/building.dart';
import 'classes/floor.dart';

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  Widget expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(List<Floor> floors, Building parent) {
  return List<Item>.generate(floors.length, (int index) {
    return Item(
      headerValue: floors[index].toString(),
      expandedValue: RoomGrid(floor: floors[index], building: parent,),
    );
  });
}

class ExpansionPanelListExample extends StatefulWidget {
  const ExpansionPanelListExample({super.key, required this.floors, required this.buildingParent});

  final List<Floor> floors;
  final Building buildingParent;

  @override
  State<ExpansionPanelListExample> createState() =>
      _ExpansionPanelListExampleState();
}

class _ExpansionPanelListExampleState extends State<ExpansionPanelListExample> {
   List<Item> _data = [];

  @override
  void initState() {
    super.initState();
    _data = generateItems(widget.floors, widget.buildingParent);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  item.isExpanded = !item.isExpanded;
                });
              },
              child: ListTile(
                title: Text(item.headerValue),
              ),
            );
          },
          body: GestureDetector(
            onTap: () {
            },
            child: ListTile(
              title: item.expandedValue,
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

class BuildingPage extends StatefulWidget {
  const BuildingPage({super.key, required this.building});
  final Building building;

  @override
  State<BuildingPage> createState() => _BuildingPageState();
}

class _BuildingPageState extends State<BuildingPage> {

  @override
  Widget build(BuildContext context) {
    Building building = widget.building;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(building.name),
        actions: [
          MenuAnchor(
            menuChildren: [
              MenuItemButton(
                child: const Text("Add a Room"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                        AddRoom(
                          building: building,
                        )),
                  );
                },
              )
            ],
            builder: (BuildContext context, MenuController controller, Widget? child) {
              return IconButton(
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                icon: const Icon(Icons.more_vert),
              );
            }
          )
        ],
      ),
      body: ExpansionPanelListExample(floors: building.floors, buildingParent: building,)
    );
  }
}

class RoomGrid extends StatelessWidget{
  const RoomGrid({super.key, required this.floor, required this.building});

  final Floor floor;
  final Building building;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: (1/.3),
      children: <Widget>[
        for ( final  (index,Room r)  in floor.rooms.indexed)
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                    RoomPage(
                      room: r,
                      building: building ,
                      roomIdx: index,
                      floorIdx: r.floor,
                    )),
              );
            }, //navigate to RoomPage(r)
            child: Text(r.name)
          )

      ]
    );
  }
}
