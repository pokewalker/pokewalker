class Pokemon {
  int id = 0;
  String name = "";
  int level = 0;
  int meters = 0;
  int metersToNextLevel = 0;
  String img = "";

  Pokemon() {
    id = 0;
    name = "";
    level = 0;
    meters = 0;
    metersToNextLevel = 0;
    img = "";
  }

  Pokemon.withData({
    required this.id,
    required this.name,
    required this.level,
    required this.meters,
    required this.metersToNextLevel,
    required this.img,
  });

  Pokemon.fromMap(map) {
    id = map["id"];
    name = map["name"];
    level = map["level"];
    meters = map["meters"];
    metersToNextLevel = map["metersToNextLevel"];
    img = map["img"];
  }

  toMap() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["level"] = level;
    map["meters"] = meters;
    map["metersToNextLevel"] = metersToNextLevel;
    map["img"] = img;
    return map;
  }
}
