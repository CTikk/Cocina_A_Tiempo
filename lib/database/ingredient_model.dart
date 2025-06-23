class Ingredient {
  final int? id;
  final String name;
  final String time;
  final String image;
  final List<String> types;

  Ingredient({
    this.id,
    required this.name,
    required this.time,
    required this.image,
    required this.types,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'time': time,
      'image': image,
      'types': types.join(','), // Guardamos como string
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      id: map['id'],
      name: map['name'],
      time: map['time'],
      image: map['image'],
      types: map['types'].split(','),
    );
  }
}