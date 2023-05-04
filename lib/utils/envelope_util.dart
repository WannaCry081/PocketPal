class Envelope {
  String envelopeId;

  String envelopeName;
  late DateTime envelopeDate;

  double envelopeStartingAmount;

  Envelope({
    this.envelopeId = "",
    required this.envelopeName,
    required this.envelopeStartingAmount,
  }){
    envelopeDate = DateTime.now();
  }

  Map<String, dynamic> toMap(){
    return {
      "envelopeId" : envelopeId,
      "envelopeName" : envelopeName,
      "envelopeDate" : envelopeDate,
      "envelopeStartingAmount" : envelopeStartingAmount
    };
  }

  factory Envelope.fromMap(Map<String, dynamic> map){
    return Envelope(
      envelopeId: map["envelopeId"],
      envelopeName: map["envelopeName"],
      envelopeStartingAmount: map["envelopeStartingAmount"],
    );
  }
}