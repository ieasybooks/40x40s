import 'dart:convert';

class EncyclopediaModel {
  final int id;
  final String encyclopediaTitle;
  final List<Hadeeth> ahadeeth;

  EncyclopediaModel({
    required this.id,
    required this.encyclopediaTitle,
    required this.ahadeeth,
  });

  factory EncyclopediaModel.fromRawJson(String str) =>
      EncyclopediaModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EncyclopediaModel.fromJson(Map<String, dynamic> json) {
    final rawHadeeth = json["ahadeeth"];
    List<Hadeeth> ahadeethList = [];

    if (rawHadeeth is List) {
      ahadeethList =
          rawHadeeth.map<Hadeeth>((x) => Hadeeth.fromJson(x)).toList();
    } else if (rawHadeeth is Map) {
      ahadeethList =
          rawHadeeth.values.map<Hadeeth>((x) => Hadeeth.fromJson(x)).toList();
    }

    return EncyclopediaModel(
      id: json["id"],
      encyclopediaTitle: json["encyclopediaـtitle"],
      ahadeeth: ahadeethList,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "encyclopediaـtitle": encyclopediaTitle,
    "ahadeeth": ahadeeth.map((x) => x.toJson()).toList(),
  };
}

class Hadeeth {
  final int id;
  final String hadeethTitle;
  final String hadeethContent;

  Hadeeth({
    required this.id,
    required this.hadeethTitle,
    required this.hadeethContent,
  });

  factory Hadeeth.fromRawJson(String str) => Hadeeth.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Hadeeth.fromJson(Map<String, dynamic> json) => Hadeeth(
    id: json["id"],
    hadeethTitle: json["hadeeth_title"],
    hadeethContent: json["hadeeth_content"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "hadeeth_title": hadeethTitle,
    "hadeeth_content": hadeethContent,
  };
}
