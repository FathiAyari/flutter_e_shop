class CatelogModel {
  static List<Item>? items;

  // Get Item by id
  Item getById(int? id) => items!.firstWhere((element) => element.id == id, orElse: null);

  // Get Item by position
  Item getByPosition(int pos) => items![pos];
}

class Item {
  final String? id;
  final String? name;
  final String? desc;
  final num price;
  final String? color;
  final String? image;
  final List users;

  Item({this.id, this.name, required this.users, this.desc, required this.price, this.color, this.image});

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      users: map['users'],
      desc: map['desc'],
      price: map['price'],
      color: map['color'],
      image: map['image'],
    );
  }

  toMap() => {
        'id': id,
        'name': name,
        'desc': desc,
        'price': price,
        'color': color,
        'image': image,
        'users': users,
      };
}
