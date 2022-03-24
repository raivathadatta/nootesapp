class Note {
  late final String id;
  final bool pin;
  final String? title;
  final String content;
  // final DateTime createdTime;

  final bool isArchieve;

  Note({
    required this.id,
    required this.pin,
    required this.isArchieve,
    required this.title,
    required this.content,
    // required this.createdTime
  });

  static Note fromJson(Map<String, Object?> json) {
    return Note(
        id: json[NotesImpNames.id] as String,
        pin: json[NotesImpNames.pin] == 1,
        title: json[NotesImpNames.title] as String,
        content: json[NotesImpNames.content] as String,
        // createdTime: DateTime.parse(json[NotesImpNames.createTime] as String),
        isArchieve: json[NotesImpNames.isArchive] == 1);
  }

  Map<String, Object?> toJson() {
    return {
      NotesImpNames.id: id,
      NotesImpNames.pin: pin ? 1 : 0,
      NotesImpNames.title: title,
      NotesImpNames.content: content,
      // NotesImpNames.createTime: createdTime.toIso8601String()
    };
  }

  Note copy(
      {String? id,
      bool? pin,
      String? title,
      String? content,
      DateTime? createdTime,
      bool? archive}) {
    return Note(
        id: id ?? this.id,
        pin: pin ?? this.pin,
        title: title ?? this.title,
        content: content ?? this.content,
        // createdTime: createdTime ?? this.createdTime,
        isArchieve: archive ?? isArchieve);
  }
}

class NotesImpNames {
  static const String id = "id";
  static String pin = "pin";
  static const String title = "title";
  static const String content = "content";
  static const String createTime = "today";
  static const String tableName = "Notes";
  static List<String> list = [id, pin, title, content, createTime, isArchive];

  static const String isArchive = 'archive';
}
