
class Wall{
  final String wallId;
  final String wallName;
  late DateTime wallDate;

  Wall({
    this.wallId = "",
    required this.wallName,
  }) {
    wallDate = DateTime.now();
  }

  Map<String, dynamic> toMap(){
    return {
      "wallId" : wallId,
      "wallName" : wallName, 
      "wallDate" : wallDate
    };
  }

  factory Wall.fromMap(Map<String, dynamic> map){
    return Wall(
     wallId : map["wallId"],
     wallName : map["wallName"],
    );
  }
}