// class HomeSliderModel {
//   HomeSliderModel({
//     required this.mainSlider,
//     required this.popularSubCategory,
//     required this.middleBanner,
//   });

//   List<MainSlider> mainSlider;
//   List<PopularSubCategory> popularSubCategory;
//   List<MainSlider> middleBanner;

//   factory HomeSliderModel.fromJson(Map<String, dynamic> json) =>
//       HomeSliderModel(
//         mainSlider: List<MainSlider>.from(
//             json["mainSlider"].map((x) => MainSlider.fromJson(x))),
//         popularSubCategory: List<PopularSubCategory>.from(
//             json["popularSubCategory"]
//                 .map((x) => PopularSubCategory.fromJson(x))),
//         middleBanner: List<MainSlider>.from(
//             json["middleBanner"].map((x) => MainSlider.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "mainSlider": List<dynamic>.from(mainSlider.map((x) => x.toJson())),
//         "popularSubCategory":
//             List<dynamic>.from(popularSubCategory.map((x) => x.toJson())),
//         "middleBanner": List<dynamic>.from(middleBanner.map((x) => x.toJson())),
//       };
// }

// class MainSlider {
//   MainSlider({
//     required this.id,
//     required this.image,
//   });

//   int id;
//   String image;

//   factory MainSlider.fromJson(Map<String, dynamic> json) => MainSlider(
//         id: json["id"],
//         image: json["image"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "image": image,
//       };
// }

// class PopularSubCategory {
//   PopularSubCategory({
//     this.id,
//     this.catName,
//   });

//   int? id;
//   String? catName;

//   factory PopularSubCategory.fromJson(Map<String, dynamic> json) =>
//       PopularSubCategory(
//         id: json["id"],
//         catName: json["catName"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "catName": catName,
//       };
// }


// To parse this JSON data, do
//
//     final homeSliderModel = homeSliderModelFromJson(jsonString);


class HomeSliderModel {
    HomeSliderModel({
        required this.success,
        required this.mainSlider,
        required this.popularSubCategory,
        required this.middleBanner,
    });

    bool success;
    List<MainSlider> mainSlider;
    List<PopularSubCategory> popularSubCategory;
    List<MiddleBanner> middleBanner;

    factory HomeSliderModel.fromJson(Map<String, dynamic> json) => HomeSliderModel(
        success: json["success"],
        mainSlider: List<MainSlider>.from(json["mainSlider"].map((x) => MainSlider.fromJson(x))),
        popularSubCategory: List<PopularSubCategory>.from(json["popularSubCategory"].map((x) => PopularSubCategory.fromJson(x))),
        middleBanner: List<MiddleBanner>.from(json["middleBanner"].map((x) => MiddleBanner.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "mainSlider": List<dynamic>.from(mainSlider.map((x) => x.toJson())),
        "popularSubCategory": List<dynamic>.from(popularSubCategory.map((x) => x.toJson())),
        "middleBanner": List<dynamic>.from(middleBanner.map((x) => x.toJson())),
    };
}

class MainSlider {
    MainSlider({
        required this.id,
        this.subHeader,
        this.header,
        this.buttonText,
        required this.link,
        required this.appLink,
        required this.image,
        required this.color,
        required this.backgroundColor,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    dynamic subHeader;
    dynamic header;
    dynamic buttonText;
    String link;
    String appLink;
    String image;
    String color;
    String backgroundColor;
    DateTime createdAt;
    DateTime updatedAt;

    factory MainSlider.fromJson(Map<String, dynamic> json) => MainSlider(
        id: json["id"],
        subHeader: json["subHeader"],
        header: json["header"],
        buttonText: json["buttonText"],
        link: json["link"],
        appLink: json["appLink"],
        image: json["image"],
        color: json["color"],
        backgroundColor: json["backgroundColor"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "subHeader": subHeader,
        "header": header,
        "buttonText": buttonText,
        "link": link,
        "appLink": appLink,
        "image": image,
        "color": color,
        "backgroundColor": backgroundColor,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class MiddleBanner {
    MiddleBanner({
        required this.id,
        this.subHeader,
        required this.header,
        this.buttonText,
        this.link,
        required this.appLink,
        required this.image,
        required this.color,
        required this.backgroundColor,
        this.createdAt,
        required this.updatedAt,
    });

    int id;
    dynamic subHeader;
    String header;
    dynamic buttonText;
    dynamic link;
    String appLink;
    String image;
    String color;
    String backgroundColor;
    dynamic createdAt;
    DateTime updatedAt;

    factory MiddleBanner.fromJson(Map<String, dynamic> json) => MiddleBanner(
        id: json["id"],
        subHeader: json["subHeader"],
        header: json["header"],
        buttonText: json["buttonText"],
        link: json["link"],
        appLink: json["appLink"],
        image: json["image"],
        color: json["color"],
        backgroundColor: json["backgroundColor"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "subHeader": subHeader,
        "header": header,
        "buttonText": buttonText,
        "link": link,
        "appLink": appLink,
        "image": image,
        "color": color,
        "backgroundColor": backgroundColor,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
    };
}

class PopularSubCategory {
    PopularSubCategory({
        required this.id,
        required this.catName,
        required this.menuId,
        required this.groupId,
        required this.isFeatured,
        required this.isMenuFeatured,
        required this.image,
        required this.createdAt,
        required this.updatedAt,
        required this.menu,
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
    Menu menu;

    factory PopularSubCategory.fromJson(Map<String, dynamic> json) => PopularSubCategory(
        id: json["id"],
        catName: json["catName"],
        menuId: json["menuId"],
        groupId: json["group_id"],
        isFeatured: json["isFeatured"],
        isMenuFeatured: json["isMenuFeatured"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        menu: Menu.fromJson(json["menu"]),
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
        "menu": menu.toJson(),
    };
}

class Menu {
    Menu({
        required this.id,
        required this.name,
    });

    int id;
    String name;

    factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
