class MenuConfigModel {
  List<Config> config;

  MenuConfigModel({this.config});

  MenuConfigModel.fromJson(Map<String, dynamic> json) {
    if (json['config'] != null) {
      config = <Config>[];
      json['config'].forEach((v) {
        config.add(Config.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (config != null) {
      data['config'] = config.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Config {
  String produitCategorieId;
  String categorie;
  String categorieIcon;
  List<SousCategories> sousCategories;

  Config(
      {this.produitCategorieId,
      this.categorie,
      this.categorieIcon,
      this.sousCategories});

  Config.fromJson(Map<String, dynamic> json) {
    produitCategorieId = json['produit_categorie_id'];
    categorie = json['categorie'];
    categorieIcon = json['categorie_icon'];
    if (json['sous_categories'] != null) {
      sousCategories = <SousCategories>[];
      json['sous_categories'].forEach((v) {
        sousCategories.add(SousCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['produit_categorie_id'] = produitCategorieId;
    data['categorie'] = categorie;
    data['categorie_icon'] = categorieIcon;
    if (sousCategories != null) {
      data['sous_categories'] = sousCategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SousCategories {
  String produitSousCategorieId;
  String sousCategorieIcon;
  String sousCategorie;
  List<FormulaireVenteDetails> formulaireVenteDetails;

  SousCategories(
      {this.produitSousCategorieId,
      this.sousCategorieIcon,
      this.sousCategorie,
      this.formulaireVenteDetails});

  SousCategories.fromJson(Map<String, dynamic> json) {
    produitSousCategorieId = json['produit_sous_categorie_id'];
    sousCategorieIcon = json['sous_categorie_icon'];
    sousCategorie = json['sous_categorie'];
    if (json['formulaire_vente_details'] != null) {
      formulaireVenteDetails = List<FormulaireVenteDetails>();
      json['formulaire_vente_details'].forEach((v) {
        formulaireVenteDetails.add(FormulaireVenteDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['produit_sous_categorie_id'] = produitSousCategorieId;
    data['sous_categorie_icon'] = sousCategorieIcon;
    data['sous_categorie'] = sousCategorie;
    if (formulaireVenteDetails != null) {
      data['formulaire_vente_details'] =
          formulaireVenteDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FormulaireVenteDetails {
  String produitSousCategorieDetailId;
  String icon;
  String sousCategorieDetail;

  FormulaireVenteDetails(
      {this.produitSousCategorieDetailId, this.icon, this.sousCategorieDetail});

  FormulaireVenteDetails.fromJson(Map<String, dynamic> json) {
    produitSousCategorieDetailId = json['produit_sous_categorie_detail_id'];
    icon = json['icon'];
    sousCategorieDetail = json['sous_categorie_detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['produit_sous_categorie_detail_id'] = produitSousCategorieDetailId;
    data['icon'] = icon;
    data['sous_categorie_detail'] = sousCategorieDetail;
    return data;
  }
}
