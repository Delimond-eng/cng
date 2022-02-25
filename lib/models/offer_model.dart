class OfferModel {
  List<Offres> offres;

  OfferModel({this.offres});

  OfferModel.fromJson(Map<String, dynamic> json) {
    if (json['offres'] != null) {
      offres = <Offres>[];
      json['offres'].forEach((v) {
        offres.add(Offres.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (offres != null) {
      data['offres'] = offres.map((v) => v.toJson()).toList();
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
      offreDetails = <OffreDetails>[];
      json['offres'].forEach((v) {
        offreDetails.add(OffreDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['produit_id'] = produitId;
    data['titre'] = titre;
    data['prix'] = prix;
    data['devise'] = devise;
    data['image'] = image;
    if (offreDetails != null) {
      data['offres'] = offreDetails.map((v) => v.toJson()).toList();
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

  OffreDetails({
    this.offreId,
    this.produitId,
    this.montant,
    this.dateEnregistrement,
    this.reponse,
  });

  OffreDetails.fromJson(Map<String, dynamic> json) {
    offreId = json['offre_id'];
    produitId = json['produit_id'];
    montant = json['montant'];
    dateEnregistrement = json['date_enregistrement'];
    reponse = json['reponse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['offre_id'] = offreId;
    data['produit_id'] = produitId;
    data['montant'] = montant;
    data['date_enregistrement'] = dateEnregistrement;
    data['reponse'] = reponse;
    return data;
  }
}
