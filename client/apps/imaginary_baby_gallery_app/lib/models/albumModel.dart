class Album {
  final userId;
  final id;
  final title;

  Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'], 
      id: json['id'],
      title: json['title'],
    );
  }
}
