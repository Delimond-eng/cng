class ChatModel {
  List<Chats> chats;

  ChatModel({this.chats});

  ChatModel.fromJson(Map<String, dynamic> json) {
    if (json['chats'] != null) {
      chats = <Chats>[];
      json['chats'].forEach((v) {
        chats.add(Chats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (chats != null) {
      data['chats'] = chats.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chats {
  String chatId;
  List<Users> users;
  List<Messages> messages;

  Chats({this.chatId, this.users, this.messages});

  Chats.fromJson(Map<String, dynamic> json) {
    chatId = json['chat_id'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users.add(Users.fromJson(v));
      });
    }
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages.add(Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    ;
    data['chat_id'] = chatId;
    if (users != null) {
      data['users'] = users.map((v) => v.toJson()).toList();
    }
    if (messages != null) {
      data['messages'] = messages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  String nom;
  String userId;

  Users({this.nom, this.userId});

  Users.fromJson(Map<String, dynamic> json) {
    nom = json['nom'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['nom'] = this.nom;
    data['user_id'] = this.userId;
    return data;
  }
}

class Messages {
  String nom;
  String messageId;
  String message;
  String userId;
  String messageStatus;
  String dateEnregistrement;
  String media;
  ChatProduit produit;

  Messages({
    this.nom,
    this.messageId,
    this.message,
    this.userId,
    this.messageStatus,
    this.dateEnregistrement,
    this.media,
    this.produit,
  });

  Messages.fromJson(Map<String, dynamic> json) {
    nom = json['nom'];
    messageId = json['message_id'];
    message = json['message'];
    userId = json['user_id'];
    messageStatus = json['message_status'];
    dateEnregistrement = json['date_enregistrement'];
    media = json['media'];
    produit = (json["produit"] != null)
        ? ChatProduit.fromJson(json["produit"])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['nom'] = nom;
    data['message_id'] = messageId;
    data['message'] = message;
    data['user_id'] = userId;
    data['message_status'] = messageStatus;
    data['date_enregistrement'] = dateEnregistrement;
    data['media'] = media;
    if (produit != null) {
      data["produit"] = produit.toJson();
    }
    return data;
  }
}

class ChatProduit {
  String produitId;
  String produitTitre;
  String produitPrix;
  String produitDevise;
  String produitImage;
  ChatProduit({
    this.produitId,
    this.produitTitre,
    this.produitPrix,
    this.produitDevise,
    this.produitImage,
  });

  ChatProduit.fromJson(Map<String, dynamic> map) {
    produitId = map["produit_id"];
    produitTitre = map["titre"];
    produitPrix = map["prix"];
    produitDevise = map["devise"];
    produitImage = map["image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["produit_id"] = produitId;
    data["titre"] = produitTitre;
    data["prix"] = produitPrix;
    data["devise"] = produitDevise;
    data["image"] = produitImage;
    return data;
  }
}
