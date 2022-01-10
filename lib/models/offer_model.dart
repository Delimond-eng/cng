class OfferModel {
  List<Offres> offres;

  OfferModel({this.offres});

  OfferModel.fromJson(Map<String, dynamic> json) {
    if (json['offres'] != null) {
      offres = new List<Offres>();
      json['offres'].forEach((v) {
        offres.add(new Offres.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.offres != null) {
      data['offres'] = this.offres.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Offres {
  String produitId;
  String titre;
  String prix;
  String devise;
  String image;
  List<OffreDetails> offreDetails;

  Offres(
      {this.produitId,
      this.titre,
      this.prix,
      this.devise,
      this.image,
      this.offreDetails});

  Offres.fromJson(Map<String, dynamic> json) {
    produitId = json['produit_id'];
    titre = json['titre'];
    prix = json['prix'];
    devise = json['devise'];
    image = json['image'];
    if (json['offres'] != null) {
      offreDetails = new List<OffreDetails>();
      json['offres'].forEach((v) {
        offreDetails.add(new OffreDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['produit_id'] = this.produitId;
    data['titre'] = this.titre;
    data['prix'] = this.prix;
    data['devise'] = this.devise;
    data['image'] = this.image;
    if (this.offreDetails != null) {
      data['offres'] = this.offreDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OffreDetails {
  String offreId;
  String produitId;
  String montant;
  String dateEnregistrement;
  String reponse;

  OffreDetails(
      {this.offreId,
      this.produitId,
      this.montant,
      this.dateEnregistrement,
      this.reponse});

  OffreDetails.fromJson(Map<String, dynamic> json) {
    offreId = json['offre_id'];
    produitId = json['produit_id'];
    montant = json['montant'];
    dateEnregistrement = json['date_enregistrement'];
    reponse = json['reponse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offre_id'] = this.offreId;
    data['produit_id'] = this.produitId;
    data['montant'] = this.montant;
    data['date_enregistrement'] = this.dateEnregistrement;
    data['reponse'] = this.reponse;
    return data;
  }
}
