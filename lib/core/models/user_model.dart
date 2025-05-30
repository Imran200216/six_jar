class UserModel {
  final String userName;
  final String userEmail;
  final String userUid;

  UserModel({
    required this.userName,
    required this.userEmail,
    required this.userUid,
  });

  // Convert JSON from FireStore to UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['userName'] ?? '',
      userEmail: json['userEmail'] ?? '',
      userUid: json['userUid'] ?? '',
    );
  }

  // Convert UserModel to JSON for FireStore
  Map<String, dynamic> toJson() {
    return {'userName': userName, 'userEmail': userEmail, 'userUid': userUid};
  }
}
