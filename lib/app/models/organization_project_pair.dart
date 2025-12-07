class OrganizationProjectPair {
  int? organizationId;
  String? organizationName;
  int? projectId;
  String? projectName;

  OrganizationProjectPair({
    this.organizationId,
    this.organizationName,
    this.projectId,
    this.projectName,
  });

  OrganizationProjectPair.fromJson(Map<String, dynamic> json) {
    organizationId = json['organization_id'];
    organizationName = json['organization_name'];
    projectId = json['project_id'];
    projectName = json['project_name'];
  }

  Map<String, dynamic> toJson() {
    return {
      "organization_id": organizationId,
      "organization_name": organizationName,
      "project_id": projectId,
      "project_name": projectName,
    };
  }
}
