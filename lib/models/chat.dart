class Chat {
  String chatId;
  String userId;
  String produitId;
  String message;
  String media;
  Chat({
    this.chatId,
    this.userId,
    this.produitId,
    this.message,
    this.media,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["user_id"] = userId;
    if (chatId != null) {
      data["chat_id"] = chatId;
    }
    if (produitId != null) {
      data["produit_id"] = produitId;
    }
    if (message != null) {
      data["message"] = message;
    }
    if (media != null) {
      data["media"] = media;
    }
    return data;
  }
}
