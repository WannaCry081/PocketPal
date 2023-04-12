class Transaction {

  String transactionId;

  String transactionName;
  late String transactionType;
  late double transactionAmount;
  late String transactionUsername;
  late DateTime transactionDate;

  Transaction({
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

  factory Transaction.fromMap(Map<String, dynamic> map){
    return Transaction(
      transactionId: map["id"],
      transactionName: map["transactionName"],
      transactionType: map["transactionType"], 
      transactionAmount: map["transactionAmount"], 
      transactionUsername: map["transactionUsername"]
    );
  }

}