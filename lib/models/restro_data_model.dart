class Restaurant {
  final int id;
  final String name;
  final String cuisine;
  final String rating;
  final String status;
  final String image;

  Restaurant({required this.id, required this.name, required this.cuisine, required this.rating, required this.status, required this.image});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      cuisine: json['cuisine'],
      rating: json['rating'],
      status: json['status'],
      image: json['image'],
    );
  }
}
