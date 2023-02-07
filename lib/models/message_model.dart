// ignore_for_file: public_member_api_docs, sort_constructors_first
class MessageModel {
  final String message;
  final String sendByMe;

  MessageModel({
    required this.message,
    required this.sendByMe,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        message: json['message'],
        sendByMe: json['sendByMe'],
      );
}
