
import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
    OrderModel({
        required this.success,
        required this.message,
        required this.order,
    });

    bool success;
    String message;
    Order order;

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        success: json["success"],
        message: json["message"],
        order: Order.fromJson(json["order"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "order": order.toJson(),
    };
}

class Order {
    Order({
        required this.total,
        required this.perPage,
        required this.page,
        required this.lastPage,
        required this.data,
    });

    int total;
    int perPage;
    int page;
    int lastPage;
    List<OrderData> data;

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        total: json["total"],
        perPage: json["perPage"],
        page: json["page"],
        lastPage: json["lastPage"],
        data: List<OrderData>.from(json["data"].map((x) => OrderData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "perPage": perPage,
        "page": page,
        "lastPage": lastPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class OrderData {
    OrderData({
        required this.id,
        required this.userId,
        required this.invoiceId,
        required this.name,
        required this.contact,
        required this.totalSellingPrice,
        required this.subTotal,
        required this.grandTotal,
        required this.roundAmount,
        required this.shippingPrice,
        this.coupon,
        this.referralCode,
        required this.discount,
        this.discountType,
        required this.refferalDiscount,
        required this.membershipDiscount,
        required this.promoDiscount,
        required this.refferalDiscountAmount,
        required this.membershipDiscountAmount,
        required this.promoDiscountAmount,
        required this.billingCity,
        required this.billingZone,
        required this.billingArea,
        required this.postCode,
        required this.billingAddress,
        required this.isDifferentShipping,
        this.shippingDetails,
        this.notes,
        required this.email,
        required this.status,
        required this.orderType,
        required this.paymentStatus,
        required this.paymentType,
        this.giftVoucherCode,
        required this.giftVoucherAmount,
        required this.isDgMoney,
        required this.dgAmount,
        this.sessionkey,
        this.bkashJson,
        required this.createdAt,
        required this.updatedAt,
        required this.orderdetails,
    });

    int id;
    int userId;
    int invoiceId;
    String name;
    String contact;
    int totalSellingPrice;
    int subTotal;
    int grandTotal;
    int roundAmount;
    int shippingPrice;
    dynamic coupon;
    dynamic referralCode;
    int discount;
    dynamic discountType;
    int refferalDiscount;
    int membershipDiscount;
    int promoDiscount;
    int refferalDiscountAmount;
    int membershipDiscountAmount;
    int promoDiscountAmount;
    String billingCity;
    String billingZone;
    String billingArea;
    String postCode;
    String billingAddress;
    int isDifferentShipping;
    dynamic shippingDetails;
    dynamic notes;
    String email;
    String status;
    String orderType;
    String paymentStatus;
    String paymentType;
    dynamic giftVoucherCode;
    int giftVoucherAmount;
    int isDgMoney;
    int dgAmount;
    dynamic sessionkey;
    dynamic bkashJson;
    String createdAt;
    DateTime updatedAt;
    List<Orderdetail> orderdetails;

    factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        id: json["id"],
        userId: json["userId"],
        invoiceId: json["invoice_id"],
        name: json["name"],
        contact: json["contact"],
        totalSellingPrice: json["totalSellingPrice"],
        subTotal: json["subTotal"],
        grandTotal: json["grandTotal"],
        roundAmount: json["roundAmount"],
        shippingPrice: json["shippingPrice"],
        coupon: json["coupon"],
        referralCode: json["referralCode"],
        discount: json["discount"],
        discountType: json["discountType"],
        refferalDiscount: json["refferalDiscount"],
        membershipDiscount: json["membershipDiscount"],
        promoDiscount: json["promoDiscount"],
        refferalDiscountAmount: json["refferalDiscountAmount"],
        membershipDiscountAmount: json["membershipDiscountAmount"],
        promoDiscountAmount: json["promoDiscountAmount"],
        billingCity: json["billingCity"],
        billingZone: json["billingZone"],
        billingArea: json["billingArea"],
        postCode: json["postCode"],
        billingAddress: json["billingAddress"],
        isDifferentShipping: json["isDifferentShipping"],
        shippingDetails: json["shippingDetails"],
        notes: json["notes"],
        email: json["email"],
        status: json["status"],
        orderType: json["orderType"],
        paymentStatus: json["paymentStatus"],
        paymentType: json["paymentType"],
        giftVoucherCode: json["giftVoucherCode"],
        giftVoucherAmount: json["giftVoucherAmount"],
        isDgMoney: json["isDGMoney"],
        dgAmount: json["dgAmount"],
        sessionkey: json["sessionkey"],
        bkashJson: json["bkashJson"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
        orderdetails: List<Orderdetail>.from(json["orderdetails"].map((x) => Orderdetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "invoice_id": invoiceId,
        "name": name,
        "contact": contact,
        "totalSellingPrice": totalSellingPrice,
        "subTotal": subTotal,
        "grandTotal": grandTotal,
        "roundAmount": roundAmount,
        "shippingPrice": shippingPrice,
        "coupon": coupon,
        "referralCode": referralCode,
        "discount": discount,
        "discountType": discountType,
        "refferalDiscount": refferalDiscount,
        "membershipDiscount": membershipDiscount,
        "promoDiscount": promoDiscount,
        "refferalDiscountAmount": refferalDiscountAmount,
        "membershipDiscountAmount": membershipDiscountAmount,
        "promoDiscountAmount": promoDiscountAmount,
        "billingCity": billingCity,
        "billingZone": billingZone,
        "billingArea": billingArea,
        "postCode": postCode,
        "billingAddress": billingAddress,
        "isDifferentShipping": isDifferentShipping,
        "shippingDetails": shippingDetails,
        "notes": notes,
        "email": email,
        "status": status,
        "orderType": orderType,
        "paymentStatus": paymentStatus,
        "paymentType": paymentType,
        "giftVoucherCode": giftVoucherCode,
        "giftVoucherAmount": giftVoucherAmount,
        "isDGMoney": isDgMoney,
        "dgAmount": dgAmount,
        "sessionkey": sessionkey,
        "bkashJson": bkashJson,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
        "orderdetails": List<dynamic>.from(orderdetails.map((x) => x.toJson())),
    };
}

class Orderdetail {
    Orderdetail({
        required this.id,
        required this.orderId,
        required this.productId,
        required this.quantity,
        required this.sellingPrice,
        required this.price,
        required this.createdAt,
        required this.updatedAt,
        required this.product,
    });

    int id;
    int orderId;
    int productId;
    int quantity;
    int sellingPrice;
    int price;
    DateTime createdAt;
    DateTime updatedAt;
    Product product;

    factory Orderdetail.fromJson(Map<String, dynamic> json) => Orderdetail(
        id: json["id"],
        orderId: json["orderId"],
        productId: json["productId"],
        quantity: json["quantity"],
        sellingPrice: json["sellingPrice"],
        price: json["price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        product: Product.fromJson(json["product"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "orderId": orderId,
        "productId": productId,
        "quantity": quantity,
        "sellingPrice": sellingPrice,
        "price": price,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "product": product.toJson(),
    };
}

class Product {
    Product({
        required this.id,
        required this.menuId,
        required this.groupId,
        required this.categoryId,
        required this.brandId,
        required this.mproductId,
        required this.productName,
        required this.unit,
        required this.model,
        required this.variation,
        required this.sellingPrice,
        required this.averageBuyingPrice,
        required this.stock,
        required this.barCode,
        this.productImage,
        this.images,
        required this.date,
        required this.openingQuantity,
        required this.openingUnitPrice,
        required this.isAvailable,
        required this.isArchived,
        required this.createdAt,
        required this.updatedAt,
        required this.variationformat,
    });

    int id;
    int menuId;
    int groupId;
    int categoryId;
    int brandId;
    int mproductId;
    String productName;
    String unit;
    String model;
    String variation;
    int sellingPrice;
    String averageBuyingPrice;
    int stock;
    String barCode;
    dynamic productImage;
    dynamic images;
    DateTime date;
    String openingQuantity;
    String openingUnitPrice;
    int isAvailable;
    int isArchived;
    DateTime createdAt;
    DateTime updatedAt;
    Variationformat variationformat;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        menuId: json["menuId"],
        groupId: json["groupId"],
        categoryId: json["categoryId"],
        brandId: json["brandId"],
        mproductId: json["mproductId"],
        productName: json["productName"],
        unit: json["unit"],
        model: json["model"],
        variation: json["variation"],
        sellingPrice: json["sellingPrice"],
        averageBuyingPrice: json["averageBuyingPrice"],
        stock: json["stock"],
        barCode: json["barCode"],
        productImage: json["productImage"],
        images: json["images"],
        date: DateTime.parse(json["date"]),
        openingQuantity: json["openingQuantity"],
        openingUnitPrice: json["openingUnitPrice"],
        isAvailable: json["isAvailable"],
        isArchived: json["is_archived"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        variationformat: Variationformat.fromJson(json["variationformat"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "menuId": menuId,
        "groupId": groupId,
        "categoryId": categoryId,
        "brandId": brandId,
        "mproductId": mproductId,
        "productName": productName,
        "unit": unit,
        "model": model,
        "variation": variation,
        "sellingPrice": sellingPrice,
        "averageBuyingPrice": averageBuyingPrice,
        "stock": stock,
        "barCode": barCode,
        "productImage": productImage,
        "images": images,
        "date": date.toIso8601String(),
        "openingQuantity": openingQuantity,
        "openingUnitPrice": openingUnitPrice,
        "isAvailable": isAvailable,
        "is_archived": isArchived,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "variationformat": variationformat.toJson(),
    };
}

class Variationformat {
    Variationformat({
        required this.color,
    });

    String color;

    factory Variationformat.fromJson(Map<String, dynamic> json) => Variationformat(
        color: json["Color"],
    );

    Map<String, dynamic> toJson() => {
        "Color": color,
    };
}
