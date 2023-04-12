class Envelope {
  String envelopeId;

  String envelopeName;
  late DateTime envelopeDate;

  Envelope({
    this.envelopeId = "",
    required this.envelopeName,
  }){
    envelopeDate = DateTime.now();
  }

  Map<String, dynamic> toMap(){
    return {
      "envelopeId" : envelopeId,
      "envelopeName" : envelopeName,
      "envelopeDate" : envelopeDate,
    };
  }

  factory Envelope.fromMap(Map<String, dynamic> map){
    return Envelope(
      envelopeId: map["envelopeId"],
      envelopeName: map["envelopeName"],
    );
  }
}