import 'package:flutter/material.dart';

//create JSON

//Main Reviews Page
class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key});
  
  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  
  String review = "This is an example of a review that is added by a user. It can include commentary on the room, location, etc. Helpful hints or suggestions may also be part of a review.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Reviews"),centerTitle: true,),
      body: Column(
        children: [
        const SizedBox(height: 22),
        Expanded(
          child:ListView.separated(
            itemCount: 8,
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
  return ListTile(
      tileColor: Colors.blueGrey,
      iconColor: Colors.yellow,
      leading: const Icon(Icons.reviews),
      trailing:const Icon(Icons.star_rate),
      title: Text("Review #$reviewNumber",style: const TextStyle(color: Colors.white),),
      subtitle: Text(reviewContent, style: const TextStyle(color: Colors.white),),
      isThreeLine: true,
      visualDensity: VisualDensity.compact
    );
 }
}