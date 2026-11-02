class Profile {
  final int id;
  final int? userId;
  final String? userGuid;
  final String? name;
  final String? status;
  final String? browserType;
  final String? browserVersion;
  final String? osFingerprint;
  final bool? screenMaximizable;
  final String? language;
  final String? acceptLanguage;

  /// Server-owned noise seed. Read-only — never sent on create/update.
  final String? fingerprintId;

  // Fingerprint surface
  final String? platformVersion;
  final String? brandVersion;
  final String? engineVersion;
  final String? gpuVendor;
  final String? gpuModel;
  final Object? hardwareConcurrency;
  final Object? deviceMemory;
  final Object? deviceScaleFactor;
  final String? mobileModel;
  final Object? mobileVersion;
  final String? chPlatform;
  final String? chPlatformVersion;
  final String? chArch;
  final String? chBitness;
  final String? chModel;
  final Object? chMobile;
  final String? disableSpoofing;

  // Geolocation spoof
  final String? locationMode;
  final String? locationLatitude;
  final String? locationLongitude;
  final String? locationAccuracy;

  final String? userAgent;
  final String? statusMachineId;
  final String? statusHeartbeatAt;
  final String? tabsSnapshot;

  Profile({
    required this.id,
    this.userId,
    this.userGuid,
    this.name,
    this.status,
    this.browserType,
    this.browserVersion,
    this.osFingerprint,
    this.screenMaximizable,
    this.language,
    this.acceptLanguage,
    this.fingerprintId,
    this.platformVersion,
    this.brandVersion,
    this.engineVersion,
    this.gpuVendor,
    this.gpuModel,
    this.hardwareConcurrency,
    this.deviceMemory,
    this.deviceScaleFactor,
    this.mobileModel,
    this.mobileVersion,
    this.chPlatform,
    this.chPlatformVersion,
    this.chArch,
    this.chBitness,
    this.chModel,
    this.chMobile,
    this.disableSpoofing,
    this.locationMode,
    this.locationLatitude,
    this.locationLongitude,
    this.locationAccuracy,
    this.userAgent,
    this.statusMachineId,
    this.statusHeartbeatAt,
    this.tabsSnapshot,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json['id'] ?? 0,
        userId: json['userId'],
        userGuid: json['userGuid'],
        name: json['name'],
        status: json['status'],
        browserType: json['browserType'],
        browserVersion: json['browserVersion'],
        osFingerprint: json['osFingerprint'],
        screenMaximizable: json['screenMaximizable'],
        language: json['language'],
        acceptLanguage: json['acceptLanguage'],
        fingerprintId: json['fingerprintId'],
        platformVersion: json['platformVersion'],
        brandVersion: json['brandVersion'],
        engineVersion: json['engineVersion'],
        gpuVendor: json['gpuVendor'],
        gpuModel: json['gpuModel'],
        hardwareConcurrency: json['hardwareConcurrency'],
        deviceMemory: json['deviceMemory'],
        deviceScaleFactor: json['deviceScaleFactor'],
        mobileModel: json['mobileModel'],
        mobileVersion: json['mobileVersion'],
        chPlatform: json['chPlatform'],
        chPlatformVersion: json['chPlatformVersion'],
        chArch: json['chArch'],
        chBitness: json['chBitness'],
        chModel: json['chModel'],
        chMobile: json['chMobile'],
        disableSpoofing: json['disableSpoofing'],
        locationMode: json['locationMode'],
        locationLatitude: json['locationLatitude'],
        locationLongitude: json['locationLongitude'],
        locationAccuracy: json['locationAccuracy'],
        userAgent: json['userAgent'],
        statusMachineId: json['statusMachineId'],
        statusHeartbeatAt: json['statusHeartbeatAt'],
        tabsSnapshot: json['tabsSnapshot'],
      );
}

class CreateProfileRequest {
  final String name;

  /// Local folder id (uuid). Generated server-side when omitted.
  final String? directoryName;
  final int? groupId;
  final int? proxyId;

  /// Brand. Chromium is not a brand — it folds to Chrome.
  final String? browserType;
  final String? browserVersion;
  final String? osFingerprint;
  final String? screenResolution;
  final bool? screenMaximizable;
  final String? language;
  final String? acceptLanguage;
  final String? timezone;
  final bool? useFingerprint;
  final String? platformVersion;
  final String? brandVersion;
  final String? engineVersion;
  final String? gpuVendor;
  final String? gpuModel;
  final Object? hardwareConcurrency;
  final Object? deviceMemory;
  final Object? deviceScaleFactor;
  final String? mobileModel;
  final Object? mobileVersion;
  final String? chPlatform;
  final String? chPlatformVersion;
  final String? chArch;
  final String? chBitness;
  final String? chModel;
  final Object? chMobile;

  /// Comma list of spoof features to turn OFF
  /// (canvas,gpu,audio,clientrects,battery,netinfo,permissions).
  final String? disableSpoofing;

  /// "", "proxy", or "manual".
  final String? locationMode;
  final String? locationLatitude;
  final String? locationLongitude;
  final String? locationAccuracy;
  final bool? restoreSession;
  final bool? lowBandwidth;
  final String? notes;
  final String? startUrl;
  final String? customFlags;
  final String? status;
  final bool? hidden;

  CreateProfileRequest({
    required this.name,
    this.directoryName,
    this.groupId,
    this.proxyId,
    this.browserType,
    this.browserVersion,
    this.osFingerprint,
    this.screenResolution,
    this.screenMaximizable,
    this.language,
    this.acceptLanguage,
    this.timezone,
    this.useFingerprint,
    this.platformVersion,
    this.brandVersion,
    this.engineVersion,
    this.gpuVendor,
    this.gpuModel,
    this.hardwareConcurrency,
    this.deviceMemory,
    this.deviceScaleFactor,
    this.mobileModel,
    this.mobileVersion,
    this.chPlatform,
    this.chPlatformVersion,
    this.chArch,
    this.chBitness,
    this.chModel,
    this.chMobile,
    this.disableSpoofing,
    this.locationMode,
    this.locationLatitude,
    this.locationLongitude,
    this.locationAccuracy,
    this.restoreSession,
    this.lowBandwidth,
    this.notes,
    this.startUrl,
    this.customFlags,
    this.status,
    this.hidden,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        if (directoryName != null) 'directoryName': directoryName,
        if (groupId != null) 'groupId': groupId,
        if (proxyId != null) 'proxyId': proxyId,
        if (browserType != null) 'browserType': browserType,
        if (browserVersion != null) 'browserVersion': browserVersion,
        if (osFingerprint != null) 'osFingerprint': osFingerprint,
        if (screenResolution != null) 'screenResolution': screenResolution,
        if (screenMaximizable != null) 'screenMaximizable': screenMaximizable,
        if (language != null) 'language': language,
        if (acceptLanguage != null) 'acceptLanguage': acceptLanguage,
        if (timezone != null) 'timezone': timezone,
        if (useFingerprint != null) 'useFingerprint': useFingerprint,
        if (platformVersion != null) 'platformVersion': platformVersion,
        if (brandVersion != null) 'brandVersion': brandVersion,
        if (engineVersion != null) 'engineVersion': engineVersion,
        if (gpuVendor != null) 'gpuVendor': gpuVendor,
        if (gpuModel != null) 'gpuModel': gpuModel,
        if (hardwareConcurrency != null) 'hardwareConcurrency': hardwareConcurrency,
        if (deviceMemory != null) 'deviceMemory': deviceMemory,
        if (deviceScaleFactor != null) 'deviceScaleFactor': deviceScaleFactor,
        if (mobileModel != null) 'mobileModel': mobileModel,
        if (mobileVersion != null) 'mobileVersion': mobileVersion,
        if (chPlatform != null) 'chPlatform': chPlatform,
        if (chPlatformVersion != null) 'chPlatformVersion': chPlatformVersion,
        if (chArch != null) 'chArch': chArch,
        if (chBitness != null) 'chBitness': chBitness,
        if (chModel != null) 'chModel': chModel,
        if (chMobile != null) 'chMobile': chMobile,
        if (disableSpoofing != null) 'disableSpoofing': disableSpoofing,
        if (locationMode != null) 'locationMode': locationMode,
        if (locationLatitude != null) 'locationLatitude': locationLatitude,
        if (locationLongitude != null) 'locationLongitude': locationLongitude,
        if (locationAccuracy != null) 'locationAccuracy': locationAccuracy,
        if (restoreSession != null) 'restoreSession': restoreSession,
        if (lowBandwidth != null) 'lowBandwidth': lowBandwidth,
        if (notes != null) 'notes': notes,
        if (startUrl != null) 'startUrl': startUrl,
        if (customFlags != null) 'customFlags': customFlags,
        if (status != null) 'status': status,
        if (hidden != null) 'hidden': hidden,
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
