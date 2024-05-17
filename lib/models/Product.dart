class Product {
  final int id;
  final String name;
  final String desc;
  final int price;
  final String color;
  final String image;
  final List<String> users;

  Product({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.users,
    required this.color,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      users: json['users'],
      name: json['name'],
      desc: json['desc'],
      price: json['price'],
      color: json['color'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'price': price,
      'color': color,
      'image': image,
    };
  }
}
