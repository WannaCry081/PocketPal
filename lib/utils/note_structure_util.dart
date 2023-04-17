class EnvelopeNotes {
  String envelopeId;

  String envelopeNoteName;
  late String envelopeNoteContent;
  late DateTime envelopeNoteDate;
  late String envelopeNoteUsername;

  EnvelopeNotes({
    required this.envelopeNoteUsername,
    required this.envelopeNoteName,
    required this.envelopeNoteContent,
    this.envelopeId = "",
  }){
    envelopeNoteDate = DateTime.now();
  }

  Map<String, dynamic> toMap(){
    return {
      "id" : envelopeId,
      "envelopeNoteName" : envelopeNoteName,
      "envelopeNoteContent" : envelopeNoteContent,
      "envelopeNoteDate" : envelopeNoteDate,
      "envelopeNoteUsername" : envelopeNoteUsername,
    };
  }

  factory EnvelopeNotes.fromMap(Map<String, dynamic> map){
    return EnvelopeNotes(
      envelopeId: map["id"],
      envelopeNoteContent: map["envelopeNoteContent"], 
      envelopeNoteName: map["envelopeNoteName"],
      envelopeNoteUsername: map["envelopeNoteUsername"],
    );
  }

}