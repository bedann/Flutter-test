// To parse this JSON data, do
//
//     final character = characterFromJson(jsonString);

import 'dart:convert';

Character characterFromJson(String str) {
    final jsonData = json.decode(str);
    return Character.fromJson(jsonData);
}

String characterToJson(Character data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class Character {
    Info info;
    List<Result> results;

    Character({
        this.info,
        this.results,
    });

    factory Character.fromJson(Map<String, dynamic> json) => new Character(
        info: Info.fromJson(json["info"]),
        results: new List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "info": info.toJson(),
        "results": new List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Info {
    int count;
    int pages;
    String next;
    String prev;

    Info({
        this.count,
        this.pages,
        this.next,
        this.prev,
    });

    factory Info.fromJson(Map<String, dynamic> json) => new Info(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
    };
}

class Result {
    int id;
    String name;
    Status status;
    Species species;
    String type;
    Gender gender;
    Location origin;
    Location location;
    String image;
    List<String> episode;
    String url;
    String created;

    Result({
        this.id,
        this.name,
        this.status,
        this.species,
        this.type,
        this.gender,
        this.origin,
        this.location,
        this.image,
        this.episode,
        this.url,
        this.created,
    });

    factory Result.fromJson(Map<String, dynamic> json) => new Result(
        id: json["id"],
        name: json["name"],
        status: statusValues.map[json["status"]],
        species: speciesValues.map[json["species"]],
        type: json["type"],
        gender: genderValues.map[json["gender"]],
        origin: Location.fromJson(json["origin"]),
        location: Location.fromJson(json["location"]),
        image: json["image"],
        episode: new List<String>.from(json["episode"].map((x) => x)),
        url: json["url"],
        created: json["created"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": statusValues.reverse[status],
        "species": speciesValues.reverse[species],
        "type": type,
        "gender": genderValues.reverse[gender],
        "origin": origin.toJson(),
        "location": location.toJson(),
        "image": image,
        "episode": new List<dynamic>.from(episode.map((x) => x)),
        "url": url,
        "created": created,
    };
}

enum Gender { MALE, FEMALE, UNKNOWN }

final genderValues = new EnumValues({
    "Female": Gender.FEMALE,
    "Male": Gender.MALE,
    "unknown": Gender.UNKNOWN
});

class Location {
    String name;
    String url;

    Location({
        this.name,
        this.url,
    });

    factory Location.fromJson(Map<String, dynamic> json) => new Location(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}

enum Species { HUMAN, ALIEN }

final speciesValues = new EnumValues({
    "Alien": Species.ALIEN,
    "Human": Species.HUMAN
});

enum Status { ALIVE, UNKNOWN, DEAD }

final statusValues = new EnumValues({
    "Alive": Status.ALIVE,
    "Dead": Status.DEAD,
    "unknown": Status.UNKNOWN
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
