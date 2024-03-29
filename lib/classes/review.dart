class Review{
  int rating = 0;
  String description= "";

  Review({required this.rating, required this.description});

  Review.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['rating'] = rating;
    data['description'] = description;
    return data;
  }

}