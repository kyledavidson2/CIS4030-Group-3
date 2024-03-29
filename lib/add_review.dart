import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:group3_4030/classes/review.dart';
import 'package:provider/provider.dart';
import 'classes/all_state.dart';
import 'classes/building.dart';
import 'classes/buildingData.dart';
import 'global_widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class AddReview extends StatefulWidget {
  AddReview({super.key, required this.buildingIdx, required this.roomIdx, required this.floorIdx});
  final int roomIdx;
  final int floorIdx;
  final int buildingIdx;
  int rating = 2;



  @override
  State<AddReview> createState() => _AddReviewState();
}
class _AddReviewState extends State<AddReview>{

  final descController = TextEditingController();
   Future<bool> submit() async{
     Building b = (Provider.of<AllStates>(context, listen: false)).buildings[widget.buildingIdx];
     double total = 0;
     double avg = 0;
     try {
       //handle case where there is ground floor or not


       b.floors[widget.floorIdx].rooms[widget.roomIdx].reviews.add(
           Review(
               rating: widget.rating,
               description: descController.text
           )
       );
       b.floors[widget.floorIdx].rooms[widget.roomIdx].numReviews = b.floors[widget.floorIdx].rooms[widget.roomIdx].reviews.length;

       b.floors[widget.floorIdx].rooms[widget.roomIdx].reviews.forEach((element) {

         total = total +element.rating;

       });
       avg = total/b.floors[widget.floorIdx].rooms[widget.roomIdx].numReviews;

       b.floors[widget.floorIdx].rooms[widget.roomIdx].rating = avg;

       BuildingData bd = BuildingData();
       final response = await bd.setBuilding((Provider.of<AllStates>(context, listen: false)).buildings[widget.buildingIdx].id, jsonEncode(b.toJson()));
       print(response.statusCode);
       print(response.body);


       await (Provider.of<AllStates>(context, listen: false)).refreshBuildings();
     } catch (e) {
       print(e);
       return false;
     }
     return true;
   }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("ADD REVIEW"),backgroundColor: Theme.of(context).colorScheme.inversePrimary,centerTitle: true,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Center(child: const Text("Choose a rating:")),
              RatingBar.builder(
                initialRating: 2,
                minRating: 1,
                direction: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) =>
                  Icon(Icons.star,
                  color: Colors.yellow,
                  ),
                onRatingUpdate: (value) {
                  setState(() {
                    widget.rating = value.toInt();
                  });

                  print("Rating applied! "+ value.toString());

                  },

              )
            ],
          ),
          Column(
            children: [
              const Text("Enter Details:"),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: descController,
                  autofocus: false,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),borderRadius: BorderRadius.circular(10)),
                    contentPadding: EdgeInsets.symmetric(vertical: 40)
                  ),
                
                ),
              ),
            ],
          ),
          AddPhotosButton(),
          ElevatedButton(
              onPressed:  () async{
                await submit();
                Navigator.of(context).pop();

          }, child: Text("Submit")

          )

        ],
      ),
      // bottomNavigationBar: MainNavigationBar(),
    );
  }
}
