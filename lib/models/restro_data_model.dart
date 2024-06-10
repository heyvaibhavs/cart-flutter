class Restaurant {
  final int id;
  final String name;
  final String cuisine;
  final String rating;
  final String status;

  Restaurant({required this.id, required this.name, required this.cuisine, required this.rating, required this.status});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      cuisine: json['cuisine'],
      rating: json['rating'],
      status: json['status'],
    );
  }
}
