class ProductModel {
  String? name;
  num? price;
  String? uid;
  String? description;

  ProductModel({this.uid,this.description,this.price,this.name});

  ProductModel.fromJson(Map<String,dynamic> json) {
    name = json['name'];
    price = json['price'];
    uid = json['uid'];
    description = json['description'];
  }

  Map<String,dynamic> toJson() => {
    'name':name,
    'price':price,
    'uid':uid,
    'description':description
  };
}