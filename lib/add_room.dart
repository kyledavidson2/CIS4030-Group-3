import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'classes/all_state.dart';

import 'classes/building.dart';
import 'classes/room.dart';
import 'global_widgets.dart';

//Main HomePage for App
class AddRoom extends StatefulWidget {
  const AddRoom({super.key, required this.building});
  final Building building;

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  final nameController = TextEditingController();
  final floorController = TextEditingController();
  final capacityController = TextEditingController();
  final descController = TextEditingController();

  Future<bool> submit() async{
    Building b = widget.building;
    try {
      int f = int.parse(floorController.text);
      b.floors[f].rooms.add(
        Room(
          name: nameController.text,
          floor: f,
          capacity: int.parse(capacityController.text),
          description: descController.text,
        )
      );
      http.Response r = await http.get(
        Uri.parse('http://35.172.228.146:8000/setbuilding?id=${widget.building.id}&data=${b.toJson()}'));

      (Provider.of<AllStates>(context)).refreshBuildings();
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          //Marker for the map
          // leading: IconButton(
          //   icon: const Icon(Icons.map),
          //   onPressed: () {
          //     print("Marker clicked!");
          //   },
          // ),
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
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              Center(
                  child: Text(
                    widget.building.name,
                style: TextStyle(fontSize: 20),
              )),
              Row(children: [
                SizedBox(
                  width: 80,
                  child: Text("Name"),
                ),
                Expanded(
                  // Constrain the width of the TextField within the Row
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Name of room',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          // ignore: prefer_interpolation_to_compose_strings
                          RegExp(r'^.{0,12}')
                        )
                      ],
                      controller: nameController,
                    ),
                  ),
                )
              ]),
              Row(children: [
                SizedBox(
                  width: 80,
                  child: Text("Floor"),
                ),
                Expanded(
                  // Constrain the width of the TextField within the Row
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: false, signed: false),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Floor (${widget.building.firstFloor().toString()}-${widget.building.lastFloor().toString()})',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          // ignore: prefer_interpolation_to_compose_strings
                          RegExp(r'^[' 
                            + widget.building.firstFloor().toString()
                            + '-'
                            + widget.building.lastFloor().toString()
                            + ']'
                          )
                        )
                      ],
                      controller: floorController,
                    ),
                  ),
                )
              ]),
              Row(children: [
                SizedBox(
                  width: 80,
                  child: Text("Capacity:"),
                ),
                Expanded(
                  // Constrain the width of the TextField within the Row
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Room Capacity',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          // ignore: prefer_interpolation_to_compose_strings
                          RegExp(r'^.{0,3}')
                        )
                      ],
                      controller: capacityController,
                    ),
                  ),
                )
              ]),
              Row(children: [
                SizedBox(
                  width: 80,
                  child: Text("Description:"),
                ),
                Expanded(
                  // Constrain the width of the TextField within the Row
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Room description',
                      ),
                      controller: descController,
                    ),
                  ),
                )
              ]),
              Padding(padding: EdgeInsets.all(10)
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [AddPhotosButton()],
              ),
              Padding(padding: EdgeInsets.all(10)
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: ()=>{Navigator.of(context).pop()}, child: Text("Back")),
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).pop();
                    submit();
                  }, child: Text("Submit"))
                ],
              )
            ],
          ),
        ));
  }
}

// TableRow(children: [
// Text("Name"),
// Expanded( // Constrain the width of the TextField within the Row
// child: Padding(
// padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
// child: TextField(
// decoration: InputDecoration(
// border: OutlineInputBorder(),
// hintText: 'Name of building',
// ),
// ),
// ),
// )
// ])
