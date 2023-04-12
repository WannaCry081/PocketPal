class Transaction {

  String transactionId;

  String transactionName;
  late String transactionType;
  late double transactionAmount;
  late DateTime transactionDate;
  late String transactionUsername;

  Transaction({
    required this.transactionName,
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
    );
  }

}