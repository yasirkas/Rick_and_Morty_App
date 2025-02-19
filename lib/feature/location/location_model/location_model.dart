class Locations {
  int? id;
  String? name;
  String? type;
  String? dimension;
  List<String>? residents;
  String? url;
  String? created;

  Locations(
      {this.id,
      this.name,
      this.type,
      this.dimension,
      this.residents,
      this.url,
      this.created});

  Locations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    dimension = json['dimension'];
    residents = json['residents'].cast<String>();
    url = json['url'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['dimension'] = dimension;
    data['residents'] = residents;
    data['url'] = url;
    data['created'] = created;
    return data;
  }
}
