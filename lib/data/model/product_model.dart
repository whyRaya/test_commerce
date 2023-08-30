class ProductModel {
  ProductModel(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image,
      required this.rating});

  ProductModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating = json['rating'] != null
        ? RatingModel.fromJson(json['rating'])
        : RatingModel();
  }

  int id = 0;
  String title = "";
  num price = 0;
  String description = "";
  String category = "";
  String image = "";
  RatingModel rating = RatingModel();

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['price'] = price;
    map['description'] = description;
    map['category'] = category;
    map['image'] = image;
    if (rating.count > 0) {
      map['rating'] = rating.toJson();
    }
    return map;
  }
}

class RatingModel {
  RatingModel({
    this.rate = -1,
    this.count = -1,
  });

  RatingModel.fromJson(dynamic json) {
    rate = json['rate'];
    count = json['count'];
  }

  num rate = -1;
  int count = -1;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rate'] = rate;
    map['count'] = count;
    return map;
  }
}

class ProductCategoriesModel {
  ProductCategoriesModel({required this.categories, required this.products});

  List<String> categories = [];
  List<ProductModel> products = [];
}
