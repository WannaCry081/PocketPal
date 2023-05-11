import 'package:cloud_firestore/cloud_firestore.dart';


class Event {
  String eventId;
  String eventName; 
  DateTime eventDate;

  Event({
    this.eventId = "",
    required this.eventName,
    required this.eventDate
  });

  @override
  String toString() => eventName;


   

  Map<String, dynamic> toMap(){
    return {
      "eventId" : eventId,
      "eventName" : eventName,
      "eventDate" : eventDate
    };
  }

  factory Event.fromMap(Map<String, dynamic> map){
    return Event(
      eventId: map["eventId"],
      eventName: map["eventName"],
      eventDate: (map["eventDate"] as Timestamp).toDate()
    );
  }
  
}

