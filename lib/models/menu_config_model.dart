class MenuConfigModel {
  List<Config> config;

  MenuConfigModel({this.config});

  MenuConfigModel.fromJson(Map<String, dynamic> json) {
    if (json['config'] != null) {
      config = new List<Config>();
      json['config'].forEach((v) {
        config.add(new Config.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.config != null) {
      data['config'] = this.config.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Config {
  String categorie;
  String categorieIcon;
  List<SousCategories> sousCategories;

  Config({this.categorie, this.categorieIcon, this.sousCategories});

  Config.fromJson(Map<String, dynamic> json) {
    categorie = json['categorie'];
    categorieIcon = json['categorie_icon'];
    if (json['sous_categories'] != null) {
      sousCategories = new List<SousCategories>();
      json['sous_categories'].forEach((v) {
        sousCategories.add(new SousCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categorie'] = this.categorie;
    data['categorie_icon'] = this.categorieIcon;
    if (this.sousCategories != null) {
      data['sous_categories'] =
          this.sousCategories.map((v) => v.toJson()).toList();
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
      formulaireVenteDetails = new List<FormulaireVenteDetails>();
      json['formulaire_vente_details'].forEach((v) {
        formulaireVenteDetails.add(new FormulaireVenteDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['produit_sous_categorie_id'] = this.produitSousCategorieId;
    data['sous_categorie_icon'] = this.sousCategorieIcon;
    data['sous_categorie'] = this.sousCategorie;
    if (this.formulaireVenteDetails != null) {
      data['formulaire_vente_details'] =
          this.formulaireVenteDetails.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['produit_sous_categorie_detail_id'] =
        this.produitSousCategorieDetailId;
    data['icon'] = this.icon;
    data['sous_categorie_detail'] = this.sousCategorieDetail;
    return data;
  }
}
