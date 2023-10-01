class ProductModel {
  final int organisationID;
  final String categoryCode;
  final String subCategoryCode;
  final String productCode;
  final String name;
  final double prize;
  final bool isActive;
  final String? categoryImage;

  ProductModel({
    required this.organisationID,
    required this.name,
    required this.categoryCode,
    required this.subCategoryCode,
    required this.productCode,
    required this.prize,
    required this.isActive,
    this.categoryImage = '',
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    String productListImage;

    if (json['ProductImagePath'].isEmpty ||
        json['ProductImagePath'].contains("no-image.png")) {
      productListImage =
          'https://jalongi.com/public/assets/images/product_not_found.jpeg';
    } else {
      productListImage = json['ProductImagePath'];
    }

    return ProductModel(
      organisationID: json['OrgId'],
      categoryCode: json['Category'],
      subCategoryCode: json['SubCategory'],
      productCode: json['ProductCode'],
      name: json['Name'],
      prize: json['SellingCost'],
      isActive: json['IsActive'],
      categoryImage: productListImage,
    );
  }
}
