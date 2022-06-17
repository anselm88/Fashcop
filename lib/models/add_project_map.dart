class AddProjectMap {
  String? projectName;
  String? projectLocation;
  String? budgetRange;
  String? estimatedProfit;
  dynamic agroSector;
  dynamic timeFrame;
  String? briefDescription;
  String? detailedDescription;
  String? projectImageURL;
  String? userID;
  DateTime? createdTime;

  AddProjectMap();
  Map<String, dynamic> toJson() => {
        'userID': userID,
        'projectName': projectName,
        'projectLocation': projectLocation,
        'budgetRange': budgetRange,
        'estimatedProfit': estimatedProfit,
        'agroSector': agroSector,
        'timeFrame': timeFrame,
        'briefDescription': briefDescription,
        'detailedDescription': detailedDescription,
        'projectImageURL': projectImageURL,
        'createdTime': createdTime,
      };
}
