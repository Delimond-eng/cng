class ProductsModel {
  Data reponse;

  ProductsModel({this.reponse});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    reponse = json['reponse'] != null ? Data.fromJson(json['reponse']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (reponse != null) {
      data['reponse'] = reponse.toJson();
    }
    return data;
  }
}

class Data {
  List<Product> produits;

  Data({this.produits});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['produits'] != null) {
      produits = <Product>[];
      json['produits'].forEach((v) {
        produits.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (produits != null) {
      data['produits'] = produits.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String produitId;
  String titre;
  String description;
  String image;
  String imageUrl;
  String prix;
  String devise;

  Product({
    this.produitId,
    this.titre,
    this.description,
    this.image,
    this.imageUrl,
    this.prix,
    this.devise,
  });

  Product.fromJson(Map<String, dynamic> json) {
    produitId = json['produit_id'];
    titre = json['titre'];
    description = json['description'];
    image = json['image'];
    imageUrl = json['media_url'];
    prix = json['prix'];
    devise = json['devise'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['produit_id'] = produitId;
    data['titre'] = titre;
    data['description'] = description;
    data['image'] = image;
    data['media_url'] = imageUrl;
    data['prix'] = prix;
    data['devise'] = devise;
    return data;
  }
}
