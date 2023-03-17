// To parse this JSON data, do
//
//     final menuDataModel = menuDataModelFromJson(jsonString);

import 'dart:convert';

import '../../auth/login/model/user_model.dart';

MenuDataModel menuDataModelFromJson(String str) =>
    MenuDataModel.fromJson(json.decode(str));

String menuDataModelToJson(MenuDataModel data) => json.encode(data.toJson());

class MenuDataModel {
  MenuDataModel({
    required this.success,
    required this.user,
    required this.menus,
  });

  bool success;
  User user;
  List<Menu> menus;

  factory MenuDataModel.fromJson(Map<String, dynamic> json) => MenuDataModel(
        success: json["success"],
        user: User.fromJson(json["user"]),
        menus: List<Menu>.from(json["menus"].map((x) => Menu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "user": user.toJson(),
        "menus": List<dynamic>.from(menus.map((x) => x.toJson())),
      };
}

class Menu {
  Menu({
    required this.id,
    required this.name,
    required this.isActive,
    this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.categories,
  });

  int id;
  String name;
  int isActive;
  dynamic content;
  DateTime createdAt;
  DateTime updatedAt;
  List<Category> categories;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        id: json["id"],
        name: json["name"],
        isActive: json["isActive"],
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "isActive": isActive,
        "content": content,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    required this.id,
    required this.image,
    required this.menuId,
    required this.groupName,
    required this.discount,
    required this.createdAt,
    required this.updatedAt,
    required this.subcategories,
  });

  int id;
  String image;
  int menuId;
  String groupName;
  int discount;
  DateTime createdAt;
  DateTime updatedAt;
  List<Subcategory> subcategories;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        image: json["image"],
        menuId: json["menuId"],
        groupName: json["groupName"],
        discount: json["discount"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        subcategories: List<Subcategory>.from(
            json["subcategories"].map((x) => Subcategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "menuId": menuId,
        "groupName": groupName,
        "discount": discount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "subcategories":
            List<dynamic>.from(subcategories.map((x) => x.toJson())),
      };
}

class Subcategory {
  Subcategory({
    required this.id,
    required this.catName,
    required this.menuId,
    required this.groupId,
    required this.isFeatured,
    required this.isMenuFeatured,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String catName;
  int menuId;
  int groupId;
  int isFeatured;
  int isMenuFeatured;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: json["id"],
        catName: json["catName"],
        menuId: json["menuId"],
        groupId: json["group_id"],
        isFeatured: json["isFeatured"],
        isMenuFeatured: json["isMenuFeatured"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "catName": catName,
        "menuId": menuId,
        "group_id": groupId,
        "isFeatured": isFeatured,
        "isMenuFeatured": isMenuFeatured,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

// class User {
//   User({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.username,
//     required this.contact,
//     required this.storeId,
//     required this.image,
//     this.deviceTokens,
//     required this.userType,
//     this.employeeId,
//     this.passportNo,
//     this.nationalId,
//     this.userRoleId,
//     this.rememberToken,
//     required this.isActive,
//     required this.otpCount,
//     this.bkashAgreementid,
//     required this.isArchived,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.customer,
//   });

//   int id;
//   String name;
//   String email;
//   String username;
//   String contact;
//   int storeId;
//   String image;
//   dynamic deviceTokens;
//   String userType;
//   dynamic employeeId;
//   dynamic passportNo;
//   dynamic nationalId;
//   dynamic userRoleId;
//   dynamic rememberToken;
//   int isActive;
//   int otpCount;
//   dynamic bkashAgreementid;
//   int isArchived;
//   DateTime createdAt;
//   DateTime updatedAt;
//   Customer customer;

//   factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json["id"],
//         name: json["name"],
//         email: json["email"],
//         username: json["username"],
//         contact: json["contact"],
//         storeId: json["store_id"],
//         image: json["image"],
//         deviceTokens: json["deviceTokens"],
//         userType: json["userType"],
//         employeeId: json["employee_id"],
//         passportNo: json["passport_no"],
//         nationalId: json["national_id"],
//         userRoleId: json["user_role_id"],
//         rememberToken: json["remember_token"],
//         isActive: json["isActive"],
//         otpCount: json["otp_count"],
//         bkashAgreementid: json["bkashAgreementid"],
//         isArchived: json["is_archived"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         customer: Customer.fromJson(json["customer"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "email": email,
//         "username": username,
//         "contact": contact,
//         "store_id": storeId,
//         "image": image,
//         "deviceTokens": deviceTokens,
//         "userType": userType,
//         "employee_id": employeeId,
//         "passport_no": passportNo,
//         "national_id": nationalId,
//         "user_role_id": userRoleId,
//         "remember_token": rememberToken,
//         "isActive": isActive,
//         "otp_count": otpCount,
//         "bkashAgreementid": bkashAgreementid,
//         "is_archived": isArchived,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "customer": customer.toJson(),
//       };
// }

// class Customer {
//   Customer({
//     required this.id,
//     required this.userId,
//     required this.customerName,
//     this.address,
//     required this.contact,
//     required this.email,
//     this.zone,
//     required this.facebook,
//     required this.instagram,
//     this.barcode,
//     this.cityId,
//     this.areaId,
//     this.zoneId,
//     this.postCode,
//     required this.opening,
//     required this.balance,
//     required this.isArchived,
//     required this.status,
//     required this.discount,
//     required this.points,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   int id;
//   int userId;
//   String customerName;
//   dynamic address;
//   String contact;
//   String email;
//   dynamic zone;
//   String facebook;
//   String instagram;
//   dynamic barcode;
//   dynamic cityId;
//   dynamic areaId;
//   dynamic zoneId;
//   dynamic postCode;
//   String opening;
//   String balance;
//   int isArchived;
//   String status;
//   int discount;
//   int points;
//   DateTime createdAt;
//   DateTime updatedAt;

//   factory Customer.fromJson(Map<String, dynamic> json) => Customer(
//         id: json["id"],
//         userId: json["userId"],
//         customerName: json["customerName"],
//         address: json["address"],
//         contact: json["contact"],
//         email: json["email"],
//         zone: json["zone"],
//         facebook: json["facebook"],
//         instagram: json["instagram"],
//         barcode: json["barcode"],
//         cityId: json["cityId"],
//         areaId: json["areaId"],
//         zoneId: json["zoneId"],
//         postCode: json["postCode"],
//         opening: json["opening"],
//         balance: json["balance"],
//         isArchived: json["is_archived"],
//         status: json["status"],
//         discount: json["discount"],
//         points: json["points"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "userId": userId,
//         "customerName": customerName,
//         "address": address,
//         "contact": contact,
//         "email": email,
//         "zone": zone,
//         "facebook": facebook,
//         "instagram": instagram,
//         "barcode": barcode,
//         "cityId": cityId,
//         "areaId": areaId,
//         "zoneId": zoneId,
//         "postCode": postCode,
//         "opening": opening,
//         "balance": balance,
//         "is_archived": isArchived,
//         "status": status,
//         "discount": discount,
//         "points": points,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }
