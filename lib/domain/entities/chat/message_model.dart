class MessageModel {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final String timestamp;
  final String? downloadableUrl;
  final String? fileName;
  final String? fileType;
  final String? orientation;

  MessageModel(
      {required this.senderId,
      required this.senderEmail,
      required this.receiverId,
      required this.message,
      required this.timestamp,
      this.downloadableUrl,
      this.fileName,
      this.fileType,
      this.orientation});

  Map<String, dynamic> toMap() {
    return {
      "senderId": senderId,
      "senderEmail": senderEmail,
      "receiverId": receiverId,
      "message": message,
      "timestamp": timestamp,
      "downloadableUrl": downloadableUrl,
      "fileName": fileName,
      "fileType": fileType,
      "orientation": orientation,
    };
  }
}
