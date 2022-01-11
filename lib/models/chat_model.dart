class ChatModel {
  List<Chats> chats;

  ChatModel({this.chats});

  ChatModel.fromJson(Map<String, dynamic> json) {
    if (json['chats'] != null) {
      chats = new List<Chats>();
      json['chats'].forEach((v) {
        chats.add(new Chats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chats != null) {
      data['chats'] = this.chats.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chats {
  String produitId;
  String chatId;
  List<Users> users;
  List<Messages> messages;

  Chats({this.produitId, this.chatId, this.users, this.messages});

  Chats.fromJson(Map<String, dynamic> json) {
    produitId = json['produit_id'];
    chatId = json['chat_id'];
    if (json['users'] != null) {
      users = new List<Users>();
      json['users'].forEach((v) {
        users.add(new Users.fromJson(v));
      });
    }
    if (json['messages'] != null) {
      messages = new List<Messages>();
      json['messages'].forEach((v) {
        messages.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['produit_id'] = this.produitId;
    data['chat_id'] = this.chatId;
    if (this.users != null) {
      data['users'] = this.users.map((v) => v.toJson()).toList();
    }
    if (this.messages != null) {
      data['messages'] = this.messages.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

  Messages(
      {this.nom,
      this.messageId,
      this.message,
      this.userId,
      this.messageStatus,
      this.dateEnregistrement,
      this.media});

  Messages.fromJson(Map<String, dynamic> json) {
    nom = json['nom'];
    messageId = json['message_id'];
    message = json['message'];
    userId = json['user_id'];
    messageStatus = json['message_status'];
    dateEnregistrement = json['date_enregistrement'];
    media = json['media'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nom'] = this.nom;
    data['message_id'] = this.messageId;
    data['message'] = this.message;
    data['user_id'] = this.userId;
    data['message_status'] = this.messageStatus;
    data['date_enregistrement'] = this.dateEnregistrement;
    data['media'] = this.media;
    return data;
  }
}
