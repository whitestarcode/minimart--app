class Product {
  final String id;
  final String title;
  final String imageUrl; 
  final double price;final String color;
  final String storage;
  final String? description;
 
  int quantity;
bool isFavorite;
  Product({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    this.quantity = 0,
    required this.color,
    required this.storage,
    this.description,
   
    this.isFavorite = false,
  });

 
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': title,
      'imageUrl': imageUrl,
      'price': price,
     
      'color': color,
      'storage': storage,
      'quantity': quantity,
      'isFavorite': isFavorite,
       'description': description,
    };
  }
}