// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
    int id;
    String productType;
    dynamic isValidated;
    String name;
    String vitamine;
    double protein;
    double carb;
    String fight;
    bool isAllergic;
    String description;
    String link;
    EdBy addedBy;
    EdBy validityChangedBy;
    String imageName;
    String createdAt;
    String updatedAt;

    Product({
        this.id,
        this.productType,
        this.isValidated,
        this.name,
        this.vitamine,
        this.protein,
        this.carb,
        this.fight,
        this.isAllergic,
        this.description,
        this.link,
        this.addedBy,
        this.validityChangedBy,
        this.imageName,
        this.createdAt,
        this.updatedAt,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        productType: json["productType"],
        isValidated: json["isValidated"],
        name: json["name"],
        vitamine: json["vitamine"],
        protein: json["protein"],
        carb: json["carb"],
        fight: json["fight"],
        isAllergic: json["isAllergic"],
        description: json["description"] == null ? null : json["description"],
        link: json["link"] == null ? null : json["link"],
        addedBy: EdBy.fromJson(json["addedBy"]),
        validityChangedBy: json["validityChangedBy"] == null ? null : EdBy.fromJson(json["validityChangedBy"]),
        imageName: json["imageName"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "productType": productType,
        "isValidated": isValidated,
        "name": name,
        "vitamine": vitamine,
        "protein": protein,
        "carb": carb,
        "fight": fight,
        "isAllergic": isAllergic,
        "description": description == null ? null : description,
        "link": link == null ? null : link,
        "addedBy": addedBy.toJson(),
        "validityChangedBy": validityChangedBy == null ? null : validityChangedBy.toJson(),
        "imageName": imageName,
        "createdAt": createdAt == null ? null : createdAt,
        "updatedAt": updatedAt == null ? null : updatedAt,
    };
}

class EdBy {
    int id;
    String name;
    String surname;
    String email;
    String username;
    dynamic createdAt;
    String updatedAt;

    EdBy({
        this.id,
        this.name,
        this.surname,
        this.email,
        this.username,
        this.createdAt,
        this.updatedAt,
    });

    factory EdBy.fromJson(Map<String, dynamic> json) => EdBy(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        email: json["email"],
        username: json["username"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "email": email,
        "username": username,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
    };
}
