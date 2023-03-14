// import "package:cloud_firestore/cloud_firestore.dart";

// class Envelope {
//   String ? envelopeName;
//   String ? folderDescription;

//   late DateTime folderDate;
//   late Timestamp folderTime;

//   late int folderNumberOfMembers;
//   late int folderNumberOfFolder;
//   late int folderNumberOfEnvelope;
//   late List folderData;

//   bool ? folderIsShared;

//   Envelope({
//     required this.envelopeName,
//     required this.folderDescription,
//     this.folderIsShared = false,
//   }){
//     folderDate = DateTime.now();
//     folderTime = Timestamp.fromDate(folderDate);

//     folderNumberOfEnvelope = 0;
//     folderNumberOfMembers = 0;
//     folderNumberOfFolder = 0;

//     folderData = [];
//   }

//   Map<String, dynamic> toMap(){
//     return {
//       "folderName" : envelopeName,
//       "folderDescription" : folderDescription,
//       "folderDate" : folderDate,
//       "folderTime" : folderTime,
//       "folderNumberOfMembers" : folderNumberOfMembers,
//       "folderNumberOfFolder" : folderNumberOfFolder,
//       "folderNumberOfEnvelope" : folderNumberOfEnvelope,
//       "folderIsShared" : folderIsShared,
//       "folderData" : folderData 
//     };
//   }

//   factory Folder.fromMap(Map<String, dynamic> map){
//     return Folder(
//       envelopeName: map["envelopeName"], 
//       folderDescription: map["folderDescription"]
//     );
//   }

// }