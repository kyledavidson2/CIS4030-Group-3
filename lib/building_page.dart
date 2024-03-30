import 'package:flutter/material.dart';
import 'package:group3_4030/add_room.dart';
import 'package:group3_4030/room_page.dart';
import 'package:provider/provider.dart';
import 'classes/all_state.dart';
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

List<Item> generateItems(List<Floor> floors, int buildingIdx) {
  return List<Item>.generate(floors.length, (int index) {
    return Item(
      headerValue: floors[index].toString(),
      expandedValue: RoomGrid(flooridx: index, buildingIdx:buildingIdx ),
    );
  });
}

class ExpansionPanelListExample extends StatefulWidget {
  const ExpansionPanelListExample({super.key, required this.floors, required this.buildingParentIdx});

  final List<Floor> floors;
  final int buildingParentIdx;

  @override
  State<ExpansionPanelListExample> createState() =>
      _ExpansionPanelListExampleState();
}

class _ExpansionPanelListExampleState extends State<ExpansionPanelListExample> {
   List<Item> _data = [];

  @override
  void initState() {
    super.initState();
    _data = generateItems(widget.floors, widget.buildingParentIdx);
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
  const BuildingPage({super.key, required this.buildingIdx});
  final int buildingIdx;

  @override
  State<BuildingPage> createState() => _BuildingPageState();
}

class _BuildingPageState extends State<BuildingPage> {

  @override
  Widget build(BuildContext context) {
    Building b = (Provider.of<AllStates>(context, listen: true)).buildings[widget.buildingIdx];
    print("number of rooms in allstate "+ (Provider.of<AllStates>(context, listen: true)).buildings[widget.buildingIdx].floors[0].rooms.length.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text((Provider.of<AllStates>(context, listen: true)).buildings[widget.buildingIdx].name),
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
                          buildingIdx: widget.buildingIdx,
                          building: b,
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
      body: ExpansionPanelListExample(floors: (Provider.of<AllStates>(context,listen: true)).buildings[widget.buildingIdx].floors, buildingParentIdx: widget.buildingIdx,)
    );
  }
}

class RoomGrid extends StatelessWidget{
  const RoomGrid({super.key, required this.flooridx, required this.buildingIdx});

  final int flooridx;
  final int buildingIdx;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: (1/.3),
      children: <Widget>[
        for ( final  (index,Room r)  in (Provider.of<AllStates>(context, listen: true)).buildings[buildingIdx].floors[flooridx].rooms.indexed)
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                    RoomPage(
                      buildingIdx: buildingIdx,
                      roomIdx: index,
                      floorIdx: ((Provider.of<AllStates>(context, listen: true)).buildings[buildingIdx].firstFloor() == 0) 
                        ? r.floor : r.floor-1, //some buildings start at 0, others start at 1. this prevents index out of range
                    )),
              );
            }, //navigate to RoomPage(r)
            child: Text(r.name)
          )

      ]
    );
  }
}
