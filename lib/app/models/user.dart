class User {
  int? id;
  String? email;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? lastName;
  String? username;
  int? avatarId;
  int? superUser;
  int? manageSupers;
  String? permissions;
  String? lastLogin;

  User({
    this.id,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.firstName,
    this.lastName,
    this.username,
    this.avatarId,
    this.superUser,
    this.manageSupers,
    this.permissions,
    this.lastLogin,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    avatarId = json['avatar_id'];
    superUser = json['super_user'];
    manageSupers = json['manage_supers'];
    permissions = json['permissions'];
    lastLogin = json['last_login'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "email_verified_at": emailVerifiedAt,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "first_name": firstName,
      "last_name": lastName,
      "username": username,
      "avatar_id": avatarId,
      "super_user": superUser,
      "manage_supers": manageSupers,
      "permissions": permissions,
      "last_login": lastLogin,
    };
  }
}

