class CategoryModel {
  int organisationID;
  int categoryCode;
  String name;
  final String description;
  final int displayOrder;
  final bool isActive;
  final String? categoryImage;

  CategoryModel({
    required this.organisationID,
    required this.name,
    required this.categoryCode,
    required this.description,
    required this.displayOrder,
    required this.isActive,
    this.categoryImage,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      organisationID: json['OrgId'],
      categoryCode: json['Code'],
      name: json['Name'],
      description: json['ChineseDescription'],
      displayOrder: json['DisplayOrder'],
      isActive: json['IsActive'],
      categoryImage: json['CategoryImage'],
    );
  }
}
