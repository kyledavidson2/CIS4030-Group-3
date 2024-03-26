import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'global_widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AddReview extends StatelessWidget{
  const AddReview({super.key});

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
                onRatingUpdate: (value) { print("Rating applied!"); },

              )
            ],
          ),
          Column(
            children: [
              const Text("Enter Details:"),
              SizedBox(
                width: 200,
                child: TextField(
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
          ElevatedButton(onPressed: ()=>{
            Navigator.of(context).pop()

          }, child: Text("Submit"))

        ],
      ),
      // bottomNavigationBar: MainNavigationBar(),
    );
  }
}
