class Pizza {
  final int id;
  final String pizzaName;
  final String description;
  final double price;
  final String imageUrl;

  Pizza({
    required this.id,
    required this.pizzaName,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  /// --- From JSON ---
  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza(
      id: _parseInt(json['id']),
      pizzaName: json['pizzaName']?.toString() ?? 'No name',
      description: json['description']?.toString() ?? '',
      price: _parseDouble(json['price']),
      imageUrl: json['imageUrl']?.toString() ?? '',
    );
  }

  /// --- To JSON ---
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pizzaName': pizzaName,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  /// --- Helper for safe parsing ---
  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? 0;
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }
}
