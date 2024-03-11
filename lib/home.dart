import 'package:flutter/material.dart';
import 'global_widgets.dart';

//Main HomePage for App
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        //Marker for the map
        leading: IconButton(
          icon: Icon(Icons.map),
          onPressed: () {
            print("Marker clicked!");
          },
          ),
        //Profile for User
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              print("User clicked!");
            },
          ),
        ],
      ),
      body: Container(
        //Image Placeholder for Maps
        decoration:BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/map.png"),
              fit: BoxFit.cover,
          )
          )
      ),
      bottomNavigationBar: MainNavigationBar(),
    );
  }
}
