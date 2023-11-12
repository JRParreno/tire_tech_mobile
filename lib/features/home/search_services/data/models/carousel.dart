// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Carousel {
  final String imageUrl;
  final String description;
  final String title;

  Carousel({
    required this.imageUrl,
    required this.description,
    required this.title,
  });

  Carousel copyWith({
    String? imageUrl,
    String? description,
    String? title,
  }) {
    return Carousel(
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'imageUrl': imageUrl});
    result.addAll({'description': description});
    result.addAll({'title': title});

    return result;
  }

  factory Carousel.fromMap(Map<String, dynamic> map) {
    return Carousel(
      imageUrl: map['imageUrl'] ?? '',
      description: map['description'] ?? '',
      title: map['title'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Carousel.fromJson(String source) =>
      Carousel.fromMap(json.decode(source));

  @override
  String toString() =>
      'Carousel(imageUrl: $imageUrl, description: $description, title: $title)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Carousel &&
        other.imageUrl == imageUrl &&
        other.description == description &&
        other.title == title;
  }

  @override
  int get hashCode => imageUrl.hashCode ^ description.hashCode ^ title.hashCode;
}
