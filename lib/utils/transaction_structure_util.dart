import "package:cloud_firestore/cloud_firestore.dart";

class EnvelopeTransaction {
  String transactionId;

  String transactionName;
  late String transactionUsername;
  late String transactionType;
  late String transactionCategory;
  late double transactionAmount;
  late DateTime transactionDate;

  EnvelopeTransaction({
    required this.transactionName,
    required this.transactionUsername,
    required this.transactionType,
    required this.transactionCategory,
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
      "transactionCategory" : transactionCategory,
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
      transactionCategory: map["transactionCategory"], 
      transactionAmount: map["transactionAmount"], 
      transactionUsername: map["transactionUsername"]
    );
  }

}