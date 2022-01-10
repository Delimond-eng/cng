class SingleProductModel {
  SingleData singleData;

  SingleProductModel({this.singleData});

  SingleProductModel.fromJson(Map<String, dynamic> json) {
    singleData = json['reponse'] != null
        ? new SingleData.fromJson(json['reponse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.singleData != null) {
      data['reponse'] = this.singleData.toJson();
    }
    return data;
  }
}

class SingleData {
  ProduitDetails produitDetails;

  SingleData({this.produitDetails});

  SingleData.fromJson(Map<String, dynamic> json) {
    produitDetails = json['produit_details'] != null
        ? new ProduitDetails.fromJson(json['produit_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.produitDetails != null) {
      data['produit_details'] = this.produitDetails.toJson();
    }
    return data;
  }
}

class ProduitDetails {
  List<Details> details;
  List<Images> images;

  ProduitDetails({this.details, this.images});

  ProduitDetails.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = new List<Details>();
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['produit_detail_id'] = this.produitDetailId;
    data['sous_categorie_detail'] = this.sousCategorieDetail;
    data['produit_detail'] = this.produitDetail;
    return data;
  }
}

class Images {
  String produitMediaId;
  String media;

  Images({this.produitMediaId, this.media});

  Images.fromJson(Map<String, dynamic> json) {
    produitMediaId = json['produit_media_id'];
    media = json['media'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['produit_media_id'] = this.produitMediaId;
    data['media'] = this.media;
    return data;
  }
}
