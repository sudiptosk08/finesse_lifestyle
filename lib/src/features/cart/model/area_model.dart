class AreaModel {
  AreaModel({
    required this.success,
    required this.areas,
  });

  bool success;
  List<Area> areas;

  factory AreaModel.fromJson(Map<String, dynamic> json) => AreaModel(
        success: json["success"],
        areas: List<Area>.from(json["areas"].map((x) => Area.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "areas": List<dynamic>.from(areas.map((x) => x.toJson())),
      };
}

class Area {
  Area({
    required this.id,
    required this.cityId,
    required this.zoneId,
    required this.name,
    this.postCode,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int cityId;
  int zoneId;
  String name;
  dynamic postCode;
  DateTime createdAt;
  DateTime updatedAt;

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"],
        cityId: json["city_id"],
        zoneId: json["zone_id"],
        name: json["name"],
        postCode: json["postCode"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city_id": cityId,
        "zone_id": zoneId,
        "name": name,
        "postCode": postCode,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
