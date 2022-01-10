class ProductsModel {
  Data reponse;

  ProductsModel({this.reponse});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    reponse =
        json['reponse'] != null ? new Data.fromJson(json['reponse']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reponse != null) {
      data['reponse'] = this.reponse.toJson();
    }
    return data;
  }
}

class Data {
  List<Product> produits;

  Data({this.produits});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['produits'] != null) {
      produits = new List<Product>();
      json['produits'].forEach((v) {
        produits.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.produits != null) {
      data['produits'] = this.produits.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String produitId;
  String titre;
  String description;
  String image;
  String prix;
  String devise;

  Product({
    this.produitId,
    this.titre,
    this.description,
    this.image,
    this.prix,
    this.devise,
  });

  Product.fromJson(Map<String, dynamic> json) {
    produitId = json['produit_id'];
    titre = json['titre'];
    description = json['description'];
    image = json['image'];
    prix = json['prix'];
    devise = json['devise'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['produit_id'] = this.produitId;
    data['titre'] = this.titre;
    data['description'] = this.description;
    data['image'] = this.image;
    data['prix'] = this.prix;
    data['devise'] = this.devise;
    return data;
  }
}
