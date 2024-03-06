import 'package:flutter/material.dart';
import 'classes/room.dart';
import 'classes/building.dart';
import 'classes/floor.dart';

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(List<Floor> floors) {
  return List<Item>.generate(floors.length, (int index) {
    return Item(
      headerValue: floors[index].toString(),
      expandedValue: 'This is item number $index',
    );
  });
}

class ExpansionPanelListExample extends StatefulWidget {
  const ExpansionPanelListExample({super.key, required this.floors});

  final List<Floor> floors;

  @override
  State<ExpansionPanelListExample> createState() =>
      _ExpansionPanelListExampleState();
}

class _ExpansionPanelListExampleState extends State<ExpansionPanelListExample> {
   List<Item> _data = [];

  @override
  void initState() {
    super.initState();
    _data = generateItems(widget.floors);
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
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
              title: Text(item.expandedValue),
              onTap: () {}
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
                child: Text("Add a Room"),
                onPressed: () {},
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
                icon: Icon(Icons.more_vert),
              );
            }
          )
        ],
      ),
      body: ExpansionPanelListExample(floors: building.floors)
    );
  }
}
