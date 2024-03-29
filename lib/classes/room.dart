



import 'package:group3_4030/classes/review.dart';

class Room {
  String name = "";
  int floor = 0;
  int capacity = 0;
  double rating = 0.0;
  int numReviews = 0;
  String description = "";
  List<Review> reviews =[];

  /* Not sure how to implement photos, maybe a list of file paths if they
  are stored locally. Or something else if they are fetched from a
  server. */

  Room({
    required this.name,
    required this.floor,
    required this.capacity,
    this.rating = 0,
    this.numReviews = 0,
    this.description = "",
  });

  Room.fromJson(Map<String, dynamic> json) {

    name = json['name'];
    floor = json['floor'];
    capacity = json['capacity'];
    if (json.containsKey('rating')){
      // print(json['name'].toString());
      if(json['rating'] is int){
        rating = json['rating'].toDouble();
      }
      else{
        rating = json['rating'];
      }

    }

    description = json['description'];

    reviews = <Review>[];
    if (json.containsKey('reviews')){
      json['reviews'].forEach((review) {
        reviews.add(Review.fromJson(review));
      });
      numReviews = reviews.length;
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['floor'] = this.floor;
    data['capacity'] = this.capacity;
    data['rating'] = this.rating;
    data['numReviews'] = this.numReviews;
    data['description'] = this.description;
    data['reviews'] = this.reviews;
    return data;
  }

}
