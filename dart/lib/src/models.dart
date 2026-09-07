class Profile {
  final int id;
  final String? name;
  final String? status;
  final String? browserType;
  final String? osFingerprint;
  final String? language;

  Profile({
    required this.id,
    this.name,
    this.status,
    this.browserType,
    this.osFingerprint,
    this.language,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json['id'] ?? 0,
        name: json['name'],
        status: json['status'],
        browserType: json['browserType'],
        osFingerprint: json['osFingerprint'],
        language: json['language'],
      );
}

class CreateProfileRequest {
  final String? name;
  final String? browserType;
  final String? osFingerprint;
  final String? language;
  final bool? useFingerprint;
  final int? groupId;
  final int? proxyId;

  CreateProfileRequest({
    this.name,
    this.browserType,
    this.osFingerprint,
    this.language,
    this.useFingerprint,
    this.groupId,
    this.proxyId,
  });

  Map<String, dynamic> toJson() => {
        if (name != null) 'name': name,
        if (browserType != null) 'browserType': browserType,
        if (osFingerprint != null) 'osFingerprint': osFingerprint,
        if (language != null) 'language': language,
        if (useFingerprint != null) 'useFingerprint': useFingerprint,
        if (groupId != null) 'groupId': groupId,
        if (proxyId != null) 'proxyId': proxyId,
      };
}

class Automation {
  final int id;
  final String? name;
  final String? description;

  Automation({required this.id, this.name, this.description});

  factory Automation.fromJson(Map<String, dynamic> json) => Automation(
        id: json['id'] ?? 0,
        name: json['name'],
        description: json['description'],
      );
}

class Group {
  final int id;
  final String? name;
  final String? description;

  Group({required this.id, this.name, this.description});

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json['id'] ?? 0,
        name: json['name'],
        description: json['description'],
      );
}

class CreateGroupRequest {
  final String? name;
  final String? description;

  CreateGroupRequest({this.name, this.description});

  Map<String, dynamic> toJson() => {
        if (name != null) 'name': name,
        if (description != null) 'description': description,
      };
}

class Proxy {
  final int id;
  final String? name;
  final String? host;
  final int? port;
  final String? protocol;

  Proxy({required this.id, this.name, this.host, this.port, this.protocol});

  factory Proxy.fromJson(Map<String, dynamic> json) => Proxy(
        id: json['id'] ?? 0,
        name: json['name'],
        host: json['host'],
        port: json['port'],
        protocol: json['protocol'],
      );
}

class CreateProxyRequest {
  final String? name;
  final String? host;
  final int? port;
  final String? protocol;
  final String? username;
  final String? password;

  CreateProxyRequest({
    this.name,
    this.host,
    this.port,
    this.protocol,
    this.username,
    this.password,
  });

  Map<String, dynamic> toJson() => {
        if (name != null) 'name': name,
        if (host != null) 'host': host,
        if (port != null) 'port': port,
        if (protocol != null) 'protocol': protocol,
        if (username != null) 'username': username,
        if (password != null) 'password': password,
      };
}

class Extension {
  final int id;
  final String? name;
  final String? version;

  Extension({required this.id, this.name, this.version});

  factory Extension.fromJson(Map<String, dynamic> json) => Extension(
        id: json['id'] ?? 0,
        name: json['name'],
        version: json['version'],
      );
}
