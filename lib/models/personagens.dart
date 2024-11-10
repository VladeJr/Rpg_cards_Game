class Character {
  final int id;
  final String name;
  final String race;
  final String profession;
  final List<int> groupIds; // IDs dos grupos aos quais o personagem pertence

  Character({
    required this.id,
    required this.name,
    required this.race,
    required this.profession,
    required this.groupIds,
  });

  // Converter o Character para um formato JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'race': race,
      'profession': profession,
      'groupIds': groupIds,
    };
  }

  // Criar um Character a partir de um JSON
  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: int.parse(json['id'].toString()), // Converte para int
      name: json['name'],
      race: json['race'],
      profession: json['profession'],
      groupIds: List<int>.from(json['groupIds'].map((groupId) => int.parse(groupId.toString()))),
    );
  }
}
