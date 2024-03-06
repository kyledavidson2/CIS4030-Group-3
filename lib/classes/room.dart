class Room {
  String name = "";
  int floor = 0;
  int capacity = 0;
  double rating = 0.0;
  int numReviews = 0;
  String description = "";

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
    rating = json['rating'];
    numReviews = json['numReviews'];
    description = json['description'];
  }

}
