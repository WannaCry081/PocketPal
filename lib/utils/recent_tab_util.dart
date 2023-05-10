class RecentTab {
  List<RecentTabItem> recentTabItem = [];

  Map<String, dynamic> toMap(){
    return {
      "recentTabItem" : recentTabItem
    };
  }
}

class RecentTabItem {
  final String itemDocId;
  final String itemDocName;
  final String itemName;
  final String itemCategory;

  late DateTime itemDateAccessed;


  RecentTabItem({
    required this.itemDocId,
    required this.itemDocName,
    required this.itemName,
    required this.itemCategory,
  })  {
    itemDateAccessed = DateTime.now();
  }

  Map<String, dynamic> toMap(){
    return {
      "itemDocId" : itemDocId,
      "itemDocName" : itemDocName,
      "itemName" : itemName,
      "itemCategory" : itemCategory,
      "itemDateAccessed" : itemDateAccessed,
    };
  }

  factory RecentTabItem.fromMap(Map<String, dynamic> map){
    return RecentTabItem(
      itemDocId: map["itemDocId"], 
      itemDocName: map["itemDocName"], 
      itemName: map["itemName"], 
      itemCategory: map["itemCategory"]
    );
  }
}