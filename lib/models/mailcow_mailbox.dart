class MailcowMailbox {
  String domain;
  String username;
  String name;
  int messages;

  MailcowMailbox({
    required this.domain,
    required this.username,
    required this.name,
    required this.messages,
  });

  factory MailcowMailbox.fromJson(Map<String, dynamic> json) {
    return MailcowMailbox(
      domain: json["domain"],
      username: json["username"],
      name: json["name"],
      messages: json["messages"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "domain": domain,
      "username": username,
      "name": name,
      "messages": messages,
    };
  }
}
