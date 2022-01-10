class UserProducts {
  List<Produits> produits;

  UserProducts({this.produits});

  UserProducts.fromJson(Map<String, dynamic> json) {
    if (json['produits'] != null) {
      produits = new List<Produits>();
      json['produits'].forEach((v) {
        produits.add(new Produits.fromJson(v));
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

class Produits {
  String produitId;
  String produitCategorieId;
  String categorie;
  String produitSousCategorieId;
  String sousCategorie;
  String titre;
  String prix;
  String devise;
  String description;
  String dateEnregistrement;
  String produitStatus;
  ProduitDetails produitDetails;
  List<Offre> offres;

  Produits({
    this.produitId,
    this.produitCategorieId,
    this.categorie,
    this.produitSousCategorieId,
    this.sousCategorie,
    this.titre,
    this.prix,
    this.devise,
    this.description,
    this.dateEnregistrement,
    this.produitStatus,
    this.produitDetails,
    this.offres,
  });

  Produits.fromJson(Map<String, dynamic> json) {
    produitId = json['produit_id'];
    produitCategorieId = json['produit_categorie_id'];
    categorie = json['categorie'];
    produitSousCategorieId = json['produit_sous_categorie_id'];
    sousCategorie = json['sous_categorie'];
    titre = json['titre'];
    prix = json['prix'];
    devise = json['devise'];
    description = json['description'];
    dateEnregistrement = json['date_enregistrement'];
    produitStatus = json['produit_status'];
    produitDetails = json['produit_details'] != null
        ? new ProduitDetails.fromJson(json['produit_details'])
        : null;
    if (json['offres'] != null) {
      offres = new List<Offre>();
      json['offres'].forEach((v) {
        offres.add(new Offre.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['produit_id'] = this.produitId;
    data['produit_categorie_id'] = this.produitCategorieId;
    data['categorie'] = this.categorie;
    data['produit_sous_categorie_id'] = this.produitSousCategorieId;
    data['sous_categorie'] = this.sousCategorie;
    data['titre'] = this.titre;
    data['prix'] = this.prix;
    data['devise'] = this.devise;
    data['description'] = this.description;
    data['date_enregistrement'] = this.dateEnregistrement;
    data['produit_status'] = this.produitStatus;
    if (this.produitDetails != null) {
      data['produit_details'] = this.produitDetails.toJson();
    }
    if (this.offres != null) {
      data["offres"] = this.offres.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Offre {
  String offreId;
  String montant;
  String dateEnregistrement;
  Offre({this.offreId, this.montant, this.dateEnregistrement});
  Offre.fromJson(Map<String, dynamic> json) {
    offreId = json["offre_id"];
    montant = json["montant"];
    dateEnregistrement = json["date_enregistrement"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["offre_id"] = offreId;
    data["montant"] = montant;
    data["date_enregistrement"] = dateEnregistrement;
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
