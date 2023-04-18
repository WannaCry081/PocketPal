import "package:cloud_firestore/cloud_firestore.dart";

class EnvelopeTransaction {
  String transactionId;

  String transactionName;
  late String transactionUsername;
  late String transactionType;
  late double transactionAmount;
  late DateTime transactionDate;

  EnvelopeTransaction({
    required this.transactionName,
    required this.transactionUsername,
    required this.transactionType,
    required this.transactionAmount,
    this.transactionId = "",
  }){
    transactionDate = DateTime.now();
  }

  Map<String, dynamic> toMap(){
    return {
      "id" : transactionId,
      "transactionName" : transactionName,
      "transactionType" : transactionType,
      "transactionAmount" : transactionAmount,
      "transactionDate" : transactionDate,
      "transactionUsername" : transactionUsername,
    };
  }

  factory EnvelopeTransaction.fromMap(Map<String, dynamic> map){
    return EnvelopeTransaction(
      transactionId: map["id"],
      transactionName: map["transactionName"],
      transactionType: map["transactionType"], 
      transactionAmount: map["transactionAmount"], 
      transactionUsername: map["transactionUsername"]
    );
  }

}