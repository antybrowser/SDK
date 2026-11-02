<?php

declare(strict_types=1);

namespace Antybrowser\SDK;

final class Profile
{
    public function __construct(
        public readonly int $id,
        public readonly string $name,
        public readonly ?int $userId = null,
        public readonly ?string $userGuid = null,
        public readonly ?string $directoryName = null,
        public readonly ?int $groupId = null,
        public readonly ?int $proxyId = null,
        public readonly ?string $browserType = null,
        public readonly ?string $browserVersion = null,
        public readonly ?string $osFingerprint = null,
        public readonly ?string $screenResolution = null,
        public readonly ?bool $screenMaximizable = null,
        public readonly ?string $language = null,
        public readonly ?string $acceptLanguage = null,
        public readonly ?string $timezone = null,
        public readonly ?bool $useFingerprint = null,
        /** Server-owned noise seed. Read-only — never sent on create/update. */
        public readonly ?string $fingerprintId = null,
        // --- Fingerprint surface ---
        public readonly ?string $platformVersion = null,
        public readonly ?string $brandVersion = null,
        public readonly ?string $engineVersion = null,
        public readonly ?string $gpuVendor = null,
        public readonly ?string $gpuModel = null,
        public readonly string|int|null $hardwareConcurrency = null,
        public readonly string|int|null $deviceMemory = null,
        public readonly string|int|null $deviceScaleFactor = null,
        public readonly ?string $mobileModel = null,
        public readonly string|int|null $mobileVersion = null,
        public readonly ?string $chPlatform = null,
        public readonly ?string $chPlatformVersion = null,
        public readonly ?string $chArch = null,
        public readonly ?string $chBitness = null,
        public readonly ?string $chModel = null,
        public readonly string|int|null $chMobile = null,
        public readonly ?string $disableSpoofing = null,
        // --- Geolocation spoof ---
        public readonly ?string $locationMode = null,
        public readonly ?string $locationLatitude = null,
        public readonly ?string $locationLongitude = null,
        public readonly ?string $locationAccuracy = null,
        public readonly ?string $userAgent = null,
        public readonly ?bool $restoreSession = null,
        public readonly ?bool $lowBandwidth = null,
        public readonly ?string $notes = null,
        public readonly ?string $startUrl = null,
        public readonly ?string $customFlags = null,
        public readonly ?string $status = null,
        public readonly ?string $statusMachineId = null,
        public readonly ?string $statusHeartbeatAt = null,
        public readonly ?bool $needsSync = null,
        public readonly ?int $lastPid = null,
        public readonly ?int $debugPort = null,
        public readonly ?string $tabsSnapshot = null,
        public readonly ?bool $hidden = null,
        public readonly ?bool $trash = null,
        public readonly ?string $deletedAt = null,
        public readonly ?string $createdAt = null,
        public readonly ?string $updatedAt = null,
        public readonly ?string $lastSyncedAt = null,
        public readonly ?string $s3Key = null,
    ) {}

    public static function fromArray(array $data): self
    {
        return new self(
            id: $data['id'],
            name: $data['name'],
            userId: $data['userId'] ?? null,
            userGuid: $data['userGuid'] ?? null,
            directoryName: $data['directoryName'] ?? null,
            groupId: $data['groupId'] ?? null,
            proxyId: $data['proxyId'] ?? null,
            browserType: $data['browserType'] ?? null,
            browserVersion: $data['browserVersion'] ?? null,
            osFingerprint: $data['osFingerprint'] ?? null,
            screenResolution: $data['screenResolution'] ?? null,
            screenMaximizable: $data['screenMaximizable'] ?? null,
            language: $data['language'] ?? null,
            acceptLanguage: $data['acceptLanguage'] ?? null,
            timezone: $data['timezone'] ?? null,
            useFingerprint: $data['useFingerprint'] ?? null,
            fingerprintId: $data['fingerprintId'] ?? null,
            platformVersion: $data['platformVersion'] ?? null,
            brandVersion: $data['brandVersion'] ?? null,
            engineVersion: $data['engineVersion'] ?? null,
            gpuVendor: $data['gpuVendor'] ?? null,
            gpuModel: $data['gpuModel'] ?? null,
            hardwareConcurrency: $data['hardwareConcurrency'] ?? null,
            deviceMemory: $data['deviceMemory'] ?? null,
            deviceScaleFactor: $data['deviceScaleFactor'] ?? null,
            mobileModel: $data['mobileModel'] ?? null,
            mobileVersion: $data['mobileVersion'] ?? null,
            chPlatform: $data['chPlatform'] ?? null,
            chPlatformVersion: $data['chPlatformVersion'] ?? null,
            chArch: $data['chArch'] ?? null,
            chBitness: $data['chBitness'] ?? null,
            chModel: $data['chModel'] ?? null,
            chMobile: $data['chMobile'] ?? null,
            disableSpoofing: $data['disableSpoofing'] ?? null,
            locationMode: $data['locationMode'] ?? null,
            locationLatitude: $data['locationLatitude'] ?? null,
            locationLongitude: $data['locationLongitude'] ?? null,
            locationAccuracy: $data['locationAccuracy'] ?? null,
            userAgent: $data['userAgent'] ?? null,
            restoreSession: $data['restoreSession'] ?? null,
            lowBandwidth: $data['lowBandwidth'] ?? null,
            notes: $data['notes'] ?? null,
            startUrl: $data['startUrl'] ?? null,
            customFlags: $data['customFlags'] ?? null,
            status: $data['status'] ?? null,
            statusMachineId: $data['statusMachineId'] ?? null,
            statusHeartbeatAt: $data['statusHeartbeatAt'] ?? null,
            needsSync: $data['needsSync'] ?? null,
            lastPid: $data['lastPid'] ?? null,
            debugPort: $data['debugPort'] ?? null,
            tabsSnapshot: $data['tabsSnapshot'] ?? null,
            hidden: $data['hidden'] ?? null,
            trash: $data['trash'] ?? null,
            deletedAt: $data['deletedAt'] ?? null,
            createdAt: $data['createdAt'] ?? null,
            updatedAt: $data['updatedAt'] ?? null,
            lastSyncedAt: $data['lastSyncedAt'] ?? null,
            s3Key: $data['s3Key'] ?? null,
        );
    }
}

final class Proxy
{
    public function __construct(
        public readonly int $id,
        public readonly ?string $name = null,
        public readonly ?string $type = null,
        public readonly ?string $host = null,
        public readonly ?int $port = null,
        public readonly ?string $username = null,
        public readonly ?string $status = null,
        public readonly ?string $countryCode = null,
        public readonly ?string $ip = null,
        public readonly ?string $country = null,
        public readonly ?string $timezone = null,
        public readonly ?string $asn = null,
        public readonly ?string $isp = null,
    ) {}

    public static function fromArray(array $data): self
    {
        return new self(
            id: $data['id'],
            name: $data['name'] ?? null,
            type: $data['type'] ?? null,
            host: $data['host'] ?? null,
            port: $data['port'] ?? null,
            username: $data['username'] ?? null,
            status: $data['status'] ?? null,
            countryCode: $data['countryCode'] ?? null,
            ip: $data['ip'] ?? null,
            country: $data['country'] ?? null,
            timezone: $data['timezone'] ?? null,
            asn: $data['asn'] ?? null,
            isp: $data['isp'] ?? null,
        );
    }
}

final class Group
{
    public function __construct(
        public readonly int $id,
        public readonly string $name,
        public readonly ?string $description = null,
        public readonly ?string $color = null,
        public readonly ?int $displayOrder = null,
    ) {}

    public static function fromArray(array $data): self
    {
        return new self(
            id: $data['id'],
            name: $data['name'],
            description: $data['description'] ?? null,
            color: $data['color'] ?? null,
            displayOrder: $data['displayOrder'] ?? null,
        );
    }
}

final class Extension
{
    public function __construct(
        public readonly int $id,
        public readonly string $name,
        public readonly ?string $path = null,
        public readonly ?string $description = null,
        public readonly ?string $icon = null,
    ) {}

    public static function fromArray(array $data): self
    {
        return new self(
            id: $data['id'],
            name: $data['name'],
            path: $data['path'] ?? null,
            description: $data['description'] ?? null,
            icon: $data['icon'] ?? null,
        );
    }
}

final class Automation
{
    public function __construct(
        public readonly int $id,
        public readonly string $name,
        public readonly ?string $description = null,
        public readonly ?string $status = null,
        public readonly ?string $lastRun = null,
    ) {}

    public static function fromArray(array $data): self
    {
        return new self(
            id: $data['id'],
            name: $data['name'],
            description: $data['description'] ?? null,
            status: $data['status'] ?? null,
            lastRun: $data['lastRun'] ?? null,
        );
    }
}
