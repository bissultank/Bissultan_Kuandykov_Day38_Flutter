class NoteDto {
  final String id;
  final String? title;
  final String? content;
  final int? createdAt; // timestamp в миллисекундах

  NoteDto({required this.id, this.title, this.content, this.createdAt});

  factory NoteDto.fromJson(Map<String, dynamic> json) {
    return NoteDto(
      id: json['id'] as String,
      title: json['title'] as String?,
      content: json['content'] as String?,
      createdAt: json['createdAt'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt,
    };
  }
}
