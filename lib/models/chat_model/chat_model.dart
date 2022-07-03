class ChatModel{
  String? senderId;
  String? receiverId;
  String? msgDateTime;
  String? msgText;


  ChatModel({
    this.senderId,
    this.receiverId,
    this.msgDateTime,
    this.msgText,

  });

  ChatModel.fromJson(Map<String, dynamic>json){
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    msgDateTime = json['msgDateTime'];
    msgText = json['msgText'];

  }

  Map<String, dynamic> toMap(){
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'msgDateTime': msgDateTime,
      'msgText': msgText,

    };
  }
}