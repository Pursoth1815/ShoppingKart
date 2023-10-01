class SubCategoryModel {
  final int organisationID;
  final String categoryCode;
  final String subCategoryCode;
  final String name;
  final String description;
  final int displayOrder;
  final bool isActive;
  final String? categoryImage;

  SubCategoryModel({
    required this.organisationID,
    required this.name,
    required this.categoryCode,
    required this.subCategoryCode,
    this.description = '',
    required this.displayOrder,
    required this.isActive,
    this.categoryImage = '',
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      organisationID: json['OrgId'],
      categoryCode: json['Code'],
      subCategoryCode: json['CategoryCode'],
      name: json['Name'],
      description: json['ChineseDescription'] ?? '',
      displayOrder: json['DisplayOrder'],
      isActive: json['IsActive'],
      categoryImage: json['CategoryImage'] ?? '',
    );
  }
}
