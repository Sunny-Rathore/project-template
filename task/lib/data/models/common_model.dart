class CommonModel {
  final String status;
  final String message;

  CommonModel({required this.status, required this.message});

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
      status: json['status'] ?? '',
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message};
  }
}
