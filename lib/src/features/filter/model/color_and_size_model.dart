import 'dart:convert';

ColorAndSizeModel colorAndSizeModelFromJson(String str) => ColorAndSizeModel.fromJson(json.decode(str));

String colorAndSizeModelToJson(ColorAndSizeModel data) => json.encode(data.toJson());

class ColorAndSizeModel {
    ColorAndSizeModel({
        required this.success,
        required this.colors,
        required this.sizes,
    });

    bool success;
    List<ColorAndSize> colors;
    List<ColorAndSize> sizes;

    factory ColorAndSizeModel.fromJson(Map<String, dynamic> json) => ColorAndSizeModel(
        success: json["success"],
        colors: List<ColorAndSize>.from(json["colors"].map((x) => ColorAndSize.fromJson(x))),
        sizes: List<ColorAndSize>.from(json["sizes"].map((x) => ColorAndSize.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "colors": List<dynamic>.from(colors.map((x) => x.toJson())),
        "sizes": List<dynamic>.from(sizes.map((x) => x.toJson())),
    };
}

class ColorAndSize {
    ColorAndSize({
        required this.value,
    });

    String value;

    factory ColorAndSize.fromJson(Map<String, dynamic> json) => ColorAndSize(
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
    };
}
