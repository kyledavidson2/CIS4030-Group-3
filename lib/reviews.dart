import 'package:flutter/material.dart';

//create JSON

//Main Reviews Page
class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key});
  
  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  
  String review = "This is an example of a review that is added by a user. It can include commentary on the room, location, etc.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
        SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: (){print("Overview");}, 
              child: Text("Overview")
            ),
            ElevatedButton(
              onPressed: (){print("Reviews");}, 
              child: Text("Reviews"),
              style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey)),
            ),
          ]
        ),
        Expanded(
          child:ListView.separated(
            itemCount: 4,
            itemBuilder: (BuildContext context, index){
              return UserReview(reviewNumber: index, reviewRating: index, reviewContent: review);
              
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 10,);
            }
            ),
        ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){print("Add Review");},
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
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.blue,
          Colors.black
        ]
        )
    ),
    child: Column(
      children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        
        children: [
          Text("Review $reviewNumber",style: TextStyle(color: Colors.white)),
          Text("$reviewRating Stars",style: TextStyle(color: Colors.white)),
        ]
      ),
     RichText(
            maxLines: 4,
            text: TextSpan(
              text: reviewContent
              ),
            ),
    
    ],
      )
  );
 }
}