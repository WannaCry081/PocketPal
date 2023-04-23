class ChatBox {
  String messageId;
  String messageUserName;
  String messageUserProfile;
  late DateTime messageDate;
  String message;

  ChatBox({
    this.messageId = "",
    required this.messageUserName,
    required this.messageUserProfile,
    required this.message
  }){
    messageDate = DateTime.now();
  }

  Map<String, dynamic> toMap(){
    return {
      "messageId" : messageId,
      "messageUserName" : messageUserName,
      "messageUserProfile" : messageUserProfile,
      "messageDate" : messageDate,
      "message" : message,
    };
  }

  factory ChatBox.fromMap(Map<String, dynamic> map){
    return ChatBox(
      messageId: map["messageId"],
      messageUserName: map["messageUserName"], 
      messageUserProfile: map["messageUserProfile"],
      message: map["message"], 
    );
  }

}