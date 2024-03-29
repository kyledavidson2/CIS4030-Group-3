import 'package:flutter/material.dart';
import 'package:group3_4030/add_review.dart';

import 'classes/building.dart';
import 'classes/room.dart';


//create JSON

//Main Reviews Page
class ReviewsPage extends StatefulWidget {
  ReviewsPage({super.key, required this.buildingIdx,required this.room, required this.floorIdx, required this.roomIdx});
  final int buildingIdx;
  final Room room;
  final int roomIdx;
  final int floorIdx;
  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  
  String review = "This is an example of a review that is added by a user. It can include commentary on the room, location, etc. Helpful hints or suggestions may also be part of a review.";
  @override
  Widget build(BuildContext context) {
    print("Room index " + widget.roomIdx.toString());
    print("floor index " + widget.floorIdx.toString());
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Reviews"),centerTitle: true,),
      body: Column(
        children: [
        const SizedBox(height: 22),
        Expanded(
          child:ListView.separated(
            itemCount: widget.room.reviews.length,
            itemBuilder: (BuildContext context,index){
              return UserReview(reviewNumber: index+1, reviewRating: widget.room.reviews[index].rating, reviewContent: widget.room.reviews[index].description);
            },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10,);
              }
          )
          // ListView.separated(
          //   itemCount: 8,
          //   itemBuilder: (BuildContext context, index){
          //     return UserReview(reviewNumber: index+1, reviewRating: index, reviewContent: review);
          //
          //   },
          //   separatorBuilder: (context, index) {
          //     return SizedBox(height: 10,);
          //   }
          //   ),
        ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddReview(buildingIdx: widget.buildingIdx, roomIdx: widget.roomIdx,floorIdx: widget.floorIdx,)),
                      );
          },
          child: Icon(Icons.add),
          ),
    );
  }
}

class UserReview extends StatelessWidget{
  const UserReview({super.key, required this.reviewNumber, required this.reviewRating, required this.reviewContent});
  final int reviewNumber;
  final int reviewRating;
  final String reviewContent;

 @override
 Widget build(BuildContext context){
  return ListTile(
      tileColor: Colors.blueGrey,
      iconColor: Colors.yellow,
      leading: const Icon(Icons.reviews),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[Text("Review #$reviewNumber",style: const TextStyle(color: Colors.white),),
          Row(
          children:[Text(reviewRating.toString(),style: const TextStyle(color: Colors.white)),
          const Icon(Icons.star_rate),]
          )
        ]
      ),
      subtitle: Text(reviewContent, style: const TextStyle(color: Colors.white),),
      isThreeLine: true,
      visualDensity: VisualDensity.compact
    );
 }
}