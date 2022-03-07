class SingleProductModel {
  SingleData singleData;

  SingleProductModel({this.singleData});

  SingleProductModel.fromJson(Map<String, dynamic> json) {
    singleData =
        json['reponse'] != null ? SingleData.fromJson(json['reponse']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (singleData != null) {
      data['reponse'] = singleData.toJson();
    }
    return data;
  }
}

class SingleData {
  ProduitDetails produitDetails;

  SingleData({
    this.produitDetails,
  });

  SingleData.fromJson(Map<String, dynamic> json) {
    produitDetails = json['produit_details'] != null
        ? ProduitDetails.fromJson(json['produit_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (produitDetails != null) {
      data['produit_details'] = produitDetails.toJson();
    }
    return data;
  }
}

class User {
  String nom;
  String email;
  String telephone;
  int cote;

  User({this.nom, this.email, this.telephone, this.cote});

  User.fromJson(Map<String, dynamic> json) {
    nom = json['nom'];
    email = json['email'];
    telephone = json['telephone'];
    cote = json['cote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['nom'] = nom;
    data['email'] = email;
    data['telephone'] = telephone;
    data['cote'] = cote;
    return data;
  }
}

class ProduitDetails {
  User user;
  List<Details> details;
  List<Images> images;

  ProduitDetails({this.details, this.images, this.user});

  ProduitDetails.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details.add(Details.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (user != null) {
      data['user'] = user.toJson();
    }
    if (details != null) {
      data['details'] = details.map((v) => v.toJson()).toList();
    }
    if (images != null) {
      data['images'] = images.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String produitDetailId;
  String sousCategorieDetail;
  String produitDetail;

  Details({this.produitDetailId, this.sousCategorieDetail, this.produitDetail});

  Details.fromJson(Map<String, dynamic> json) {
    produitDetailId = json['produit_detail_id'];
    sousCategorieDetail = json['sous_categorie_detail'];
    produitDetail = json['produit_detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['produit_detail_id'] = produitDetailId;
    data['sous_categorie_detail'] = sousCategorieDetail;
    data['produit_detail'] = produitDetail;
    return data;
  }
}

class Images {
  String produitMediaId;
  String media;
  String mediaUrl;

  Images({this.produitMediaId, this.media, this.mediaUrl});

  Images.fromJson(Map<String, dynamic> json) {
    produitMediaId = json['produit_media_id'];
    media = json['media'];
    mediaUrl = json['media_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['produit_media_id'] = produitMediaId;
    data['media'] = media;
    data['media_url'] = mediaUrl;
    return data;
  }
}
