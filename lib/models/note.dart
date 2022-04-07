class Note {
  late final String id;
  final bool pin;
  final String? title;
  final String content;
  //  final DateTime dateTime;
  final bool isArchieve;

  Note({
    // required this.dateTime,
    required this.id,
    required this.pin,
    required this.isArchieve,
    required this.title,
    required this.content,
  });

  static Note formDocument(Map<String, Object?> doc) {
    return Note(
      // dateTime: doc[time] as DateTime,
      id: doc[idFeld] as String,
      pin: doc[pinFeld] as bool,
      isArchieve: doc[isArchiveFeld] as bool,
      title: doc[titleFeld] as String,
      content: doc[contentFeld] as String,
    );
  }

  // static Note toDocment

  static Note fromJson(Map<String, Object?> json) {
    return Note(
      id: json[NoteConstants.id] as String,
      pin: json[NoteConstants.pin] == 1,
      title: json[NoteConstants.title] as String,
      content: json[NoteConstants.content] as String,
      isArchieve: json[NoteConstants.isArchive] == 1,
      //  dateTime: json[time] as DateTime
    );
  }

  Map<String, Object?> toJson() {
    return {
      NoteConstants.id: id,
      NoteConstants.pin: pin ? 1 : 0,
      NoteConstants.title: title,
      NoteConstants.content: content,
    };
  }

  // Note copy(
  //     {String? id,
  //     bool? pin,
  //     String? title,
  //     String? content,
  //     DateTime? createdTime,
  //     bool? archive}) {
  //   return Note(
  //       id: id ?? this.id,
  //       pin: pin ?? this.pin,
  //       title: title ?? this.title,
  //       content: content ?? this.content,
  //       isArchieve: archive ?? isArchieve, dateTime: null);
  // }
}

const titleFeld = "title";
const contentFeld = "content";
const pinFeld = "pin";
const isArchiveFeld = "isArchieve";
const idFeld = "id";
const time = 'time';

class NoteConstants {
  static const String id = "id";
  static String pin = "pin";
  static const String title = "title";
  static const String content = "content";
  static const String createTime = "today";
  static const String tableName = "Notes";
  static List<String> list = [id, pin, title, content, createTime, isArchive];
  static const String isArchive = 'archive';
}
