import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'classes/building.dart';
import 'global_widgets.dart';

//Main HomePage for App
class AddRoom extends StatefulWidget {
  const AddRoom({super.key, required this.building});
  final Building building;

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
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
                  ElevatedButton(onPressed: ()=>{
                    Navigator.of(context).pop()

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
