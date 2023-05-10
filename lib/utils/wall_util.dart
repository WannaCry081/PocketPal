
class Wall{
  final String wallId;
  final String wallName;
  late DateTime wallDate;
  late List<WallUser> wallMembers;

  Wall({
    this.wallId = "",
    required this.wallName
  }) {
    wallDate = DateTime.now();
    wallMembers = [];
  }

  Map<String, dynamic> toMap(){
    return {
      "wallId" : wallId,
      "wallName" : wallName, 
      "wallDate" : wallDate,
      "wallMembers" : wallMembers
    };
  }

  factory Wall.fromMap(Map<String, dynamic> map){
    return Wall(
      wallId : map["wallId"],
      wallName : map["wallName"]
    );
  }
}

class WallUser {
  final String wallUserName;
  final String wallUserEmail;
  final String wallUserProfile;
  
  // 1 - Admin
  // 2 - Editors
  // 3 - Members
  final int wallUserAuthorizationKey;
  
  WallUser({
    required this.wallUserName,
    required this.wallUserEmail,
    required this.wallUserProfile,
    this.wallUserAuthorizationKey = 3, 
  });

  Map<String, dynamic> toMap(){
    return {
      "wallUserName" : wallUserName,
      "wallUserEmail" : wallUserEmail,
      "wallUserProfile" : wallUserProfile, 
      "wallUserAuthorizationKey" : wallUserAuthorizationKey
    };
  }

  factory WallUser.fromMap(Map<String, dynamic> map){
    return WallUser(
     wallUserName : map["wallUserName"],
     wallUserEmail : map["wallUserEmail"],
     wallUserProfile : map["wallUserProfile"],
     wallUserAuthorizationKey : map["wallUserAuthorizationKey"],
    );
  }

}