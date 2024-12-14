class Item {
  final String addItemName;
  final int addItemPrice;
  final String id;

  Item({
    required this.addItemName,
    required this.addItemPrice,
    required this.id,
  });

  // Factory method to create an Item object from JSON
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      addItemName: json['item'],
      addItemPrice: json['itemPrice'],
      id: json['_id'],
    );
  }

  int get totalPrice => addItemPrice;

  // Method to convert an Item object to JSON
  Map<String, dynamic> toJson() {
    return {
      'itemName': addItemName,
      'itemPrice': addItemPrice,
      '_id': id,
    };
  }
}
