export interface Profile {
  id: number;
  name: string;
  directoryName?: string | null;
  groupId?: number | null;
  proxyId?: number | null;
  browserType?: string | null;
  browserVersion?: string | null;
  osFingerprint?: string | null;
  screenResolution?: string | null;
  language?: string | null;
  acceptLanguage?: string | null;
  timezone?: string | null;
  useFingerprint?: boolean | null;
  fingerprintId?: string | null;
  restoreSession?: boolean | null;
  lowBandwidth?: boolean | null;
  notes?: string | null;
  startUrl?: string | null;
  customFlags?: string | null;
  status?: string | null;
  needsSync?: boolean | null;
  lastPid?: number | null;
  debugPort?: number | null;
  createdAt?: string | null;
  updatedAt?: string | null;
  lastSyncedAt?: string | null;
  s3Key?: string | null;
  trash?: boolean | null;
  deletedAt?: string | null;
  hidden?: boolean | null;
}

export interface CreateProfileRequest {
  name: string;
  directoryName?: string;
  groupId?: number | null;
  proxyId?: number | null;
  browserType?: string;
  browserVersion?: string | null;
  osFingerprint?: string;
  screenResolution?: string;
  language?: string;
  acceptLanguage?: string;
  timezone?: string;
  useFingerprint?: boolean;
  fingerprintId?: string;
  restoreSession?: boolean;
  lowBandwidth?: boolean;
  notes?: string | null;
  startUrl?: string | null;
  customFlags?: string | null;
}

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
  createdAt?: string | null;
  updatedAt?: string | null;
}

export interface CreateProxyRequest {
  name: string;
  host: string;
  port: number;
  username?: string;
  password?: string;
  type: "http" | "socks4" | "socks5";
}

export interface ProxyCheckResult {
  success: boolean;
  details?: {
    ip?: string;
    country?: string;
    countryCode?: string;
    city?: string;
    region?: string;
    timezone?: string;
    isp?: string;
    asn?: string;
    asnType?: string;
    org?: string;
    usageType?: string;
    domain?: string;
    isResidential?: boolean;
    privacy?: any;
    hostnames?: string[];
    riskAssessment?: any;
  };
  errorMessage?: string;
}

export interface Group {
  id: number;
  name: string;
  description?: string | null;
  color?: string | null;
  displayOrder?: number | null;
  createdAt?: string | null;
  updatedAt?: string | null;
}

export interface CreateGroupRequest {
  name: string;
  description?: string;
  color?: string;
}

export interface Extension {
  id: number;
  name: string;
  path?: string | null;
  description?: string | null;
  icon?: string | null;
  iconDataUrl?: string | null;
  createdAt?: string | null;
}

export interface Automation {
  id: number;
  name: string;
  description?: string | null;
  detectedVariables?: any | null;
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

export interface Settings {
  id?: number;
  chromePath?: string | null;
  licenseKey?: string | null;
  defaultBrowserType?: string | null;
  defaultOsFingerprint?: string | null;
  defaultScreenResolution?: string | null;
  defaultLanguage?: string | null;
  defaultAcceptLanguage?: string | null;
  defaultTimezone?: string | null;
  defaultLowBandwidth?: boolean | null;
  apiEnabled?: boolean | null;
  apiKey?: string | null;
  language?: string | null;
  onCloseAction?: "minimize" | "exit" | null;
  launchOnStartup?: boolean | null;
  launchMinimizedOnStartup?: boolean | null;
  ipQualityScoreApiKey?: string | null;
  useIpQualityScore?: boolean | null;
  browserFlags?: string | null;
  fontSizeScale?: string | null;
  [key: string]: any;
}

export interface SyncStatus {
  active: any[];
  activeExtensions: any[];
  total: number;
  completed: number;
  errors: Record<string, any>;
  progress: Record<string, any>;
  isSyncing: boolean;
}

export interface StatusResponse {
  success: boolean;
  status: string;
  version: string;
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
