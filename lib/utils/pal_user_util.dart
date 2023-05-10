import 'package:pocket_pal/utils/wall_util.dart';

class PalUser {
  
  final String palUserName;
  final String palUserEmail;
  final int palUserNumberOfFolders;
  final int palUserNumberOfEnvelopes;
  final int palUserNumberOfGroups;

  late List<Wall> palUserGroupWall;
  late DateTime palUserDateJoined;

  PalUser({
    required this.palUserName,
    required this.palUserEmail,
    this.palUserNumberOfFolders = 0,
    this.palUserNumberOfEnvelopes = 0,
    this.palUserNumberOfGroups = 0,
  }){
    palUserDateJoined = DateTime.now(); 
    palUserGroupWall = [];
  }

  Map<String, dynamic> toMap(){
    return {
      "palUserName" : palUserName,
      "palUserEmail" : palUserEmail,
      "palUserNumberOfFolders" : palUserNumberOfFolders,
      "palUserNumberOfEnvelopes" : palUserNumberOfEnvelopes,
      "palUserNumberOfGroups" : palUserNumberOfGroups,
      "palUserDateJoined" : palUserDateJoined,
      "palUserGroupWall" : palUserGroupWall
    };
  }

  factory PalUser.fromMap(Map<String, dynamic> map){
    return PalUser(
      palUserName: map["palUserName"], 
      palUserEmail: map["palUserEmail"], 
      palUserNumberOfFolders: map["palUserNumberOfFolders"], 
      palUserNumberOfEnvelopes: map["palUserNumberOfEnvelopes"], 
      palUserNumberOfGroups: map["palUserNumberOfGroups"], 
    );
  }
}