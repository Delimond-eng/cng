class UserProducts {
  List<Produits> produits;

  UserProducts({this.produits});

  UserProducts.fromJson(Map<String, dynamic> json) {
    if (json['produits'] != null) {
      produits = <Produits>[];
      json['produits'].forEach((v) {
        produits.add(Produits.fromJson(v));
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
        ? ProduitDetails.fromJson(json['produit_details'])
        : null;
    if (json['offres'] != null) {
      offres = <Offre>[];
      json['offres'].forEach((v) {
        offres.add(Offre.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['produit_id'] = produitId;
    data['produit_categorie_id'] = produitCategorieId;
    data['categorie'] = categorie;
    data['produit_sous_categorie_id'] = produitSousCategorieId;
    data['sous_categorie'] = sousCategorie;
    data['titre'] = titre;
    data['prix'] = prix;
    data['devise'] = devise;
    data['description'] = description;
    data['date_enregistrement'] = dateEnregistrement;
    data['produit_status'] = produitStatus;
    if (produitDetails != null) {
      data['produit_details'] = produitDetails.toJson();
    }
    if (offres != null) {
      data['offres'] = offres.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProduitDetails {
  User user;
  List<Details> details;
  List<Images> images;

  ProduitDetails({this.user, this.details, this.images});

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
    final Map<String, dynamic> data = {};
    data['nom'] = nom;
    data['email'] = email;
    data['telephone'] = telephone;
    data['cote'] = cote;
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
    final Map<String, dynamic> data = {};
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

class Offre {
  String offreId;
  String montant;
  String dateEnregistrement;

  Offre({this.offreId, this.montant, this.dateEnregistrement});

  Offre.fromJson(Map<String, dynamic> json) {
    offreId = json['offre_id'];
    montant = json['montant'];
    dateEnregistrement = json['date_enregistrement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['offre_id'] = offreId;
    data['montant'] = montant;
    data['date_enregistrement'] = dateEnregistrement;
    return data;
  }
}
