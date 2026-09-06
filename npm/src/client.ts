import { AntybrowserError } from "./errors";
import type {
  Profile,
  CreateProfileRequest,
  Proxy,
  CreateProxyRequest,
  ProxyCheckResult,
  Group,
  CreateGroupRequest,
  Extension,
  Automation,
  RunAutomationRequest,
  RunAutomationResult,
  Settings,
  SyncStatus,
  StatusResponse,
  StartProfileResponse,
  ApiResponse,
  DuplicateProfileRequest,
} from "./types";

export interface AntybrowserClientOptions {
  apiKey: string;
  baseUrl?: string;
  port?: number;
  timeout?: number;
}

export class AntybrowserClient {
  private readonly apiKey: string;
  private readonly baseUrl: string;
  private readonly timeout: number;

  constructor(apiKeyOrOptions: string | AntybrowserClientOptions) {
    if (typeof apiKeyOrOptions === "string") {
      this.apiKey = apiKeyOrOptions;
      this.baseUrl = "http://127.0.0.1:5173";
      this.timeout = 30_000;
    } else {
      this.apiKey = apiKeyOrOptions.apiKey;
      const port = apiKeyOrOptions.port ?? 5173;
      this.baseUrl = apiKeyOrOptions.baseUrl ?? `http://127.0.0.1:${port}`;
      this.timeout = apiKeyOrOptions.timeout ?? 30_000;
    }
  }

  // ─── System ──────────────────────────────────────────────────────────────

  async getStatus(): Promise<StatusResponse> {
    return this.get<StatusResponse>("/api/status");
  }

  async getSettings(): Promise<Settings> {
    return this.get<Settings>("/api/settings");
  }

  async getSyncStatus(): Promise<SyncStatus> {
    return this.get<SyncStatus>("/api/sync/status");
  }

  async refreshSync(profileId?: number): Promise<ApiResponse> {
    return this.post<ApiResponse>("/api/sync/refresh", profileId != null ? { profileId } : undefined);
  }

  // ─── Profiles ────────────────────────────────────────────────────────────

  async getProfiles(): Promise<Profile[]> {
    return this.get<Profile[]>("/api/profiles");
  }

  async createProfile(data: CreateProfileRequest): Promise<Profile> {
    return this.post<Profile>("/api/profiles", data);
  }

  async updateProfile(id: number, data: Partial<CreateProfileRequest>): Promise<Profile> {
    return this.put<Profile>(`/api/profiles/${id}`, data);
  }

  async deleteProfile(id: number): Promise<ApiResponse> {
    return this.delete<ApiResponse>(`/api/profiles/${id}`);
  }

  async startProfile(id: number): Promise<StartProfileResponse> {
    return this.post<StartProfileResponse>(`/api/profiles/${id}/start`);
  }

  async stopProfile(id: number): Promise<ApiResponse> {
    return this.post<ApiResponse>(`/api/profiles/${id}/stop`);
  }

  async duplicateProfile(id: number, options?: DuplicateProfileRequest): Promise<Profile> {
    return this.post<Profile>(`/api/profiles/${id}/duplicate`, options);
  }

  // ─── Automations ─────────────────────────────────────────────────────────

  async getAutomations(): Promise<Automation[]> {
    return this.get<Automation[]>("/api/automations");
  }

  async runAutomation(id: number, data: RunAutomationRequest): Promise<RunAutomationResult> {
    return this.post<RunAutomationResult>(`/api/automations/${id}/run`, data);
  }

  // ─── Groups ──────────────────────────────────────────────────────────────

  async getGroups(): Promise<Group[]> {
    return this.get<Group[]>("/api/groups");
  }

  async createGroup(data: CreateGroupRequest): Promise<Group> {
    return this.post<Group>("/api/groups", data);
  }

  async updateGroup(id: number, data: Partial<CreateGroupRequest>): Promise<Group> {
    return this.put<Group>(`/api/groups/${id}`, data);
  }

  async deleteGroup(id: number): Promise<void> {
    await this.delete<void>(`/api/groups/${id}`);
  }

  // ─── Proxies ─────────────────────────────────────────────────────────────

  async getProxies(): Promise<Proxy[]> {
    return this.get<Proxy[]>("/api/proxies");
  }

  async createProxy(data: CreateProxyRequest): Promise<Proxy> {
    return this.post<Proxy>("/api/proxies", data);
  }

  async checkProxy(data: { host: string; port: number; username?: string; password?: string; type?: string }): Promise<ProxyCheckResult> {
    return this.post<ProxyCheckResult>("/api/proxies/check", data);
  }

  async checkProxiesBulk(proxies: Array<string | { host: string; port: number; username?: string; password?: string; type?: string }>): Promise<ProxyCheckResult[]> {
    const result = await this.post<{ success: boolean; results: ProxyCheckResult[] }>("/api/proxies/check-bulk", { proxies });
    return result.results;
  }

  async deleteProxy(id: number): Promise<void> {
    await this.delete<void>(`/api/proxies/${id}`);
  }

  // ─── Extensions ──────────────────────────────────────────────────────────

  async getExtensions(): Promise<Extension[]> {
    return this.get<Extension[]>("/api/extensions");
  }

  async deleteExtension(id: number): Promise<void> {
    await this.delete<void>(`/api/extensions/${id}`);
  }

  async getProfileExtensions(profileId: number, details = false): Promise<Extension[]> {
    return this.get<Extension[]>(`/api/profiles/${profileId}/extensions?details=${details}`);
  }

  async setProfileExtensions(profileId: number, extensionIds: number[]): Promise<ApiResponse> {
    return this.post<ApiResponse>(`/api/profiles/${profileId}/extensions`, { extensionIds });
  }

  // ─── HTTP Helpers ────────────────────────────────────────────────────────

  private async get<T>(path: string): Promise<T> {
    const response = await this.request("GET", path);
    return this.handleResponse<T>(response);
  }

  private async post<T>(path: string, body?: unknown): Promise<T> {
    const response = await this.request("POST", path, body);
    return this.handleResponse<T>(response);
  }

  private async put<T>(path: string, body: unknown): Promise<T> {
    const response = await this.request("PUT", path, body);
    return this.handleResponse<T>(response);
  }

  private async delete<T>(path: string): Promise<T> {
    const response = await this.request("DELETE", path);
    return this.handleResponse<T>(response);
  }

  private async request(method: string, path: string, body?: unknown): Promise<Response> {
    const url = `${this.baseUrl}${path}`;
    const headers: Record<string, string> = {
      "x-api-key": this.apiKey,
      "Content-Type": "application/json",
    };

    const init: RequestInit = {
      method,
      headers,
      signal: AbortSignal.timeout(this.timeout),
    };

    if (body !== undefined) {
      init.body = JSON.stringify(body);
    }

    try {
      return await fetch(url, init);
    } catch (error: any) {
      if (error?.name === "TimeoutError" || error?.name === "AbortError") {
        throw new AntybrowserError(`Request to ${path} timed out after ${this.timeout}ms`);
      }
      throw new AntybrowserError(`Failed to connect to Antybrowser Local API at ${this.baseUrl}. Is Antybrowser running?\n${error?.message ?? error}`);
    }
  }

  private async handleResponse<T>(response: Response): Promise<T> {
    const text = await response.text();

    if (!response.ok) {
      throw new AntybrowserError(
        `API request failed with status ${response.status}`,
        response.status,
        text
      );
    }

    if (!text || text.trim() === "") {
      return undefined as T;
    }

    try {
      return JSON.parse(text) as T;
    } catch {
      throw new AntybrowserError("Invalid JSON response from API", response.status, text);
    }
  }
}
