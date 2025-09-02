import 'dart:convert';

class EncyclopediaModel {
  final int id;
  final String title;
  final List<Hadith> hadiths;

  EncyclopediaModel({
    required this.id,
    required this.title,
    required this.hadiths,
  });

  factory EncyclopediaModel.fromRawJson(String str) =>
      EncyclopediaModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EncyclopediaModel.fromJson(Map<String, dynamic> json) {
    final rawHadith = json["hadiths"];
    List<Hadith> hadithsList = [];

    if (rawHadith is List) {
      hadithsList =
          rawHadith.map<Hadith>((x) => Hadith.fromJson(x)).toList();
    } else if (rawHadith is Map) {
      hadithsList =
          rawHadith.values.map<Hadith>((x) => Hadith.fromJson(x)).toList();
    }

    return EncyclopediaModel(
      id: json["id"],
      title: json["title"],
      hadiths: hadithsList,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "hadiths": hadiths.map((x) => x.toJson()).toList(),
  };
}

class Hadith {
  final int id;
  final String title;
  final String text;

  Hadith({
    required this.id,
    required this.title,
    required this.text,
  });

  factory Hadith.fromRawJson(String str) => Hadith.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Hadith.fromJson(Map<String, dynamic> json) => Hadith(
    id: json["id"],
    title: json["title"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "text": text,
  };
}
