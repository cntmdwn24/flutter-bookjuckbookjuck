class Book {
  final String title;
  final String description;
  final String imageUrl;
  final List<String> authors;

  Book({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.authors,
  });

  // JSON 데이터를 Book 객체로 변환
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['volumeInfo']['title'] ?? 'No title',
      description: json['volumeInfo']['description'] ?? 'No description available',
      imageUrl: json['volumeInfo']['imageLinks']?['thumbnail'] ?? 'https://via.placeholder.com/150',
      authors: json['volumeInfo']['authors'] != null
          ? List<String>.from(json['volumeInfo']['authors'])
          : ['Unknown author'],
    );
  }
}
