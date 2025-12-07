import 'user.dart';

class Student {
  int? id;
  int? userId;
  String? phone;
  String? civilNumber;
  String? image;
  String? createdAt;
  String? updatedAt;
  User? user;

  Student({
    this.id,
    this.userId,
    this.phone,
    this.civilNumber,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    phone = json['phone'];
    civilNumber = json['civil_number'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "phone": phone,
      "civil_number": civilNumber,
      "image": image,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "user": user?.toJson(),
    };
  }
}

