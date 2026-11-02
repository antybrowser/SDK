export interface Profile {
  id: number;
  userId?: number | null;
  userGuid?: string | null;
  name: string;
  directoryName?: string | null;
  groupId?: number | null;
  proxyId?: number | null;
  browserType?: string | null;
  browserVersion?: string | null;
  osFingerprint?: string | null;
  screenResolution?: string | null;
  screenMaximizable?: boolean | null;
  language?: string | null;
  acceptLanguage?: string | null;
  timezone?: string | null;
  useFingerprint?: boolean | null;
  /** Server-owned noise seed. Read-only — never sent on create/update. */
  fingerprintId?: string | null;
  // --- Fingerprint surface ---
  platformVersion?: string | null;
  brandVersion?: string | null;
  engineVersion?: string | null;
  gpuVendor?: string | null;
  gpuModel?: string | null;
  hardwareConcurrency?: string | number | null;
  deviceMemory?: string | number | null;
  deviceScaleFactor?: string | number | null;
  mobileModel?: string | null;
  mobileVersion?: string | number | null;
  chPlatform?: string | null;
  chPlatformVersion?: string | null;
  chArch?: string | null;
  chBitness?: string | null;
  chModel?: string | null;
  chMobile?: string | number | null;
  disableSpoofing?: string | null;
  // --- Geolocation spoof ---
  locationMode?: string | null;
  locationLatitude?: string | null;
  locationLongitude?: string | null;
  locationAccuracy?: string | null;
  userAgent?: string | null;
  restoreSession?: boolean | null;
  lowBandwidth?: boolean | null;
  notes?: string | null;
  startUrl?: string | null;
  customFlags?: string | null;
  status?: string | null;
  statusMachineId?: string | null;
  statusHeartbeatAt?: string | null;
  needsSync?: boolean | null;
  lastPid?: number | null;
  /** Always null on the row — read the live port from the start response. */
  debugPort?: number | null;
  tabsSnapshot?: string | null;
  hidden?: boolean | null;
  trash?: boolean | null;
  deletedAt?: string | null;
  createdAt?: string | null;
  updatedAt?: string | null;
  lastSyncedAt?: string | null;
  s3Key?: string | null;
}

export interface CreateProfileRequest {
  name: string;
  /** Local folder id (uuid). Generated server-side when omitted. */
  directoryName?: string;
  groupId?: number | null;
  proxyId?: number | null;
  /** Brand. Chromium is not a brand — it folds to Chrome. */
  browserType?: "Chrome" | "Edge" | "Opera" | "Vivaldi" | "Brave";
  browserVersion?: string | null;
  osFingerprint?: string;
  screenResolution?: string;
  screenMaximizable?: boolean;
  language?: string;
  acceptLanguage?: string;
  timezone?: string;
  useFingerprint?: boolean;
  platformVersion?: string;
  brandVersion?: string;
  engineVersion?: string;
  gpuVendor?: string;
  gpuModel?: string;
  hardwareConcurrency?: string | number;
  deviceMemory?: string | number;
  deviceScaleFactor?: string | number;
  mobileModel?: string;
  mobileVersion?: string | number;
  chPlatform?: string;
  chPlatformVersion?: string;
  chArch?: string;
  chBitness?: string;
  chModel?: string;
  chMobile?: string | number;
  /** Comma list of spoof features to turn OFF (canvas,gpu,audio,clientrects,battery,netinfo,permissions). */
  disableSpoofing?: string;
  locationMode?: "" | "proxy" | "manual";
  locationLatitude?: string;
  locationLongitude?: string;
  locationAccuracy?: string;
  restoreSession?: boolean;
  lowBandwidth?: boolean;
  notes?: string | null;
  startUrl?: string | null;
  customFlags?: string | null;
  status?: string;
  hidden?: boolean;
}

export type UpdateProfileRequest = Partial<CreateProfileRequest>;

export interface Proxy {
  id: number;
  name?: string | null;
  type?: string | null;
  host?: string | null;
  port?: number | null;
  username?: string | null;
  password?: string | null;
  status?: string | null;
  countryCode?: string | null;
  city?: string | null;
  region?: string | null;
  isp?: string | null;
  isResidential?: boolean | null;
  checkDetails?: any | null;
  lastChecked?: string | null;
  lastCheckAt?: string | null;
  ip?: string | null;
  country?: string | null;
  timezone?: string | null;
  asn?: string | null;
  asnType?: string | null;
  usageType?: string | null;
  domain?: string | null;
  org?: string | null;
  privacy?: any | null;
  hostnames?: string[] | null;
  errorMessage?: string | null;
  ipChangeCount?: number | null;
  /** OS family the exit's TCP/IP stack looks like, from the exit probe. */
  exitOs?: string | null;
  exitOsConfidence?: string | null;
  exitFingerprint?: any | null;
  createdAt?: string | null;
  updatedAt?: string | null;
}

export interface CreateProxyRequest {
  name: string;
  host: string;
  port: number;
  username?: string;
  password?: string;
  type?: "http" | "https" | "socks4" | "socks5";
}

export interface Group {
  id: number;
  userId?: number | null;
  name: string;
  description?: string | null;
  color?: string | null;
  displayOrder?: number | null;
}

export interface CreateGroupRequest {
  name: string;
  description?: string;
  color?: string;
}

export interface Extension {
  id: number;
  userId?: number | null;
  type?: string | null;
  name: string;
  description?: string | null;
  version?: string | null;
  /** Chrome Web Store id (or an internal GUID for sideloaded zips). */
  guid?: string | null;
  icon?: string | null;
  iconUrl?: string | null;
  /** Machine-specific absolute path — never reuse it on another OS. */
  localPath?: string | null;
  source?: string | null;
  s3Key?: string | null;
  size?: number | null;
  synced?: boolean | null;
  needsSync?: boolean | null;
  createdAt?: string | null;
  updatedAt?: string | null;
}

export interface Automation {
  id: number;
  name: string;
  description?: string | null;
  /** JSON string. */
  detectedVariables?: any | null;
  /** JSON string. */
  customVariables?: any | null;
  lastRun?: string | null;
  status?: string | null;
  createdAt?: string | null;
  updatedAt?: string | null;
}

export interface RunAutomationRequest {
  profileId: number;
  deleteCookies?: boolean;
  variables?: Record<string, string>;
}

export interface RunAutomationResult {
  success: boolean;
  message: string;
  variables?: Record<string, any>;
}

export interface StartProfileResponse {
  success: boolean;
  data: {
    debugPort?: number;
    [key: string]: any;
  };
}

export interface ApiResponse<T = any> {
  success?: boolean;
  message?: string;
  data?: T;
  [key: string]: any;
}

export interface DuplicateProfileRequest {
  name?: string;
  directoryName?: string;
}
