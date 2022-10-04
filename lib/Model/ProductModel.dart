class ProductModel{
String? id;
String? Name;
String? ShortDescription;
String? price;


ProductModel({
  this.id,
  this.Name,
  this.price,
  this.ShortDescription,
});

ProductModel.fromJson(Map<dynamic, dynamic> Json){
  id=Json['id'].toString();
  Name=Json['Name'].toString();
  price=Json['Price'].toString();
  ShortDescription=Json['ShortDescription'].toString();
}

}