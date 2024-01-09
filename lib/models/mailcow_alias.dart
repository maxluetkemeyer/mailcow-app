class MailcowAlias {
  String domain;
  String goto;
  String address;
  int id;

  MailcowAlias({
    required this.domain,
    required this.goto,
    required this.address,
    required this.id,
  });

  factory MailcowAlias.fromJson(Map<String, dynamic> json) {
    return MailcowAlias(
      domain: json["domain"],
      goto: json["goto"],
      address: json["address"],
      id: json["id"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "domain": domain,
      "goto": goto,
      "address": address,
      "id": id,
    };
  }
}
