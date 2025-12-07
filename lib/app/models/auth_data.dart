import 'student.dart';
import 'organization_project_pair.dart';

class AuthData {
  Student? student;
  String? token;
  List<OrganizationProjectPair>? organizationsProjectsPairs;

  AuthData({this.student, this.token, this.organizationsProjectsPairs});

  AuthData.fromJson(Map<String, dynamic> json) {
    student = json['student'] != null ? Student.fromJson(json['student']) : null;
    token = json['token'];
    organizationsProjectsPairs = json['organizations_projects_pairs'] != null
        ? (json['organizations_projects_pairs'] as List)
        .map((e) => OrganizationProjectPair.fromJson(e))
        .toList()
        : [];
  }

  Map<String, dynamic> toJson() {
    return {
      "student": student?.toJson(),
      "token": token,
      "organizations_projects_pairs":
      organizationsProjectsPairs?.map((e) => e.toJson()).toList(),
    };
  }
}
