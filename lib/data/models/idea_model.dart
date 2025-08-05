class IdeaModel {
  final String id;
  final String title;
  final String tagline;
  final String description;
  final String? imageUrl;
  final double rating;
  final int votes;
  final DateTime createdAt;
  final String authorId;

  IdeaModel({
    required this.id,
    required this.title,
    required this.tagline,
    required this.description,
    this.imageUrl,
    this.rating = 0.0,
    this.votes = 0,
    DateTime? createdAt,
    required this.authorId,
  }) : createdAt = createdAt ?? DateTime.now();

  factory IdeaModel.fromJson(Map<String, dynamic> json) {
    return IdeaModel(
      id: json['id'] as String,
      title: json['title'] as String,
      tagline: json['tagline'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      votes: (json['votes'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt'] as String) : null,
      authorId: json['authorId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'tagline': tagline,
      'description': description,
      'imageUrl': imageUrl,
      'rating': rating,
      'votes': votes,
      'createdAt': createdAt.toIso8601String(),
      'authorId': authorId,
    };
  }

  IdeaModel copyWith({
    String? id,
    String? title,
    String? tagline,
    String? description,
    String? imageUrl,
    double? rating,
    int? votes,
    DateTime? createdAt,
    String? authorId,
  }) {
    return IdeaModel(
      id: id ?? this.id,
      title: title ?? this.title,
      tagline: tagline ?? this.tagline,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      votes: votes ?? this.votes,
      createdAt: createdAt ?? this.createdAt,
      authorId: authorId ?? this.authorId,
    );
  }
}
