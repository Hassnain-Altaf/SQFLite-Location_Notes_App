class Note {
  int? id;
  String locationName;
  String description;
  String imagePath;

  Note({
    this.id,
    required this.locationName,
    required this.description,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'locationName': locationName,
      'description': description,
      'imagePath': imagePath,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      locationName: map['locationName'],
      description: map['description'],
      imagePath: map['imagePath'],
    );
  }
}
