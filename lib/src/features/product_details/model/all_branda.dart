// To parse this JSON data, do
//
//     final brandModel = brandModelFromJson(jsonString);

import 'dart:convert';

BrandModel brandModelFromJson(String str) => BrandModel.fromJson(json.decode(str));

String brandModelToJson(BrandModel data) => json.encode(data.toJson());

class BrandModel {
    BrandModel({
        required this.success,
        required this.brands,
    });

    bool success;
    List<Brand> brands;

    factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
        success: json["success"],
        brands: List<Brand>.from(json["brands"].map((x) => Brand.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "brands": List<dynamic>.from(brands.map((x) => x.toJson())),
    };
}

class Brand {
    Brand({
        required this.id,
        required this.name,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String name;
    DateTime createdAt;
    DateTime updatedAt;

    factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
