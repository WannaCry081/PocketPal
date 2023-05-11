import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:pocket_pal/services/database_service.dart";
import 'package:pocket_pal/utils/event_util.dart';


class EventProvider with ChangeNotifier {
  
 String ? _orderBy;

  set setOrderBy(String ? orderBy){
    _orderBy = orderBy;
    notifyListeners();
  }

  List<Event> _eventList = [];
  Map<DateTime, List<Event>> _eventMap = {};

  List<Event> get getEventList => _eventList;
  Map<DateTime, List<Event>>  get getEventMap => _eventMap;

  Future<void>  fetchEvent() async {
    QuerySnapshot querySnapshot = await PocketPalFirestore()
      .getEventSnapshot(
        orderBy: _orderBy ,
      );

    _eventList = querySnapshot.docs.map(
      (doc) => Event.fromMap(doc.data() as Map<String, dynamic>)
    ).toList();

    // _eventMap = {};
    // for (Event event in _eventList) {
    //   DateTime date = event.eventDate;
    //   if (_eventMap.containsKey(date)) {
    //     _eventMap[date]!.add(event);
    //   } else {
    //     _eventMap[date] = [event];
    //   }
    // }
    _eventMap = {};
    querySnapshot.docs.forEach((document) {
      DateTime eventDate = (document.get("eventDate") as Timestamp).toDate();
      String eventName = document.get("eventName") as String;

      final event = Event(eventName: eventName, eventDate: eventDate);
        if (_eventMap.containsKey(eventDate)){
          _eventMap[eventDate]!.add(event);
        } else {
          _eventMap[eventDate] = [event];
        }
     });

    // _eventList = _eventMap.values.expand((events) => events).toList();
    
    notifyListeners();
    return; 
  } 

  Future<void> addEvent(Map<String, dynamic> data) async {
    await PocketPalFirestore().addEvent(data);
    fetchEvent();
    return;
  }

  Future<void> deleteEvent(String docName) async {
    await PocketPalFirestore().deleteEvent(docName);
    fetchEvent();
    return;
  }
}