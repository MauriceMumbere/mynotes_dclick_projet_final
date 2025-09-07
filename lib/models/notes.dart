class Notes{
  int? id;
  String title;
  String content;

  Notes({
    this.id,
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      "id" : id,
      "title" : title,
      "content" : content,
    };
  }

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
        id: map["id"],
        title: map["title"],
        content: map["content"]);
  }
}