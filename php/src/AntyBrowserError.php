<?php

declare(strict_types=1);

namespace AntyBrowser\SDK;

final class AntyBrowserError extends \RuntimeException
{
    public function __construct(
        string $message,
        public readonly ?int $statusCode = null,
        public readonly ?string $responseBody = null,
    ) {
        parent::__construct($message);
    }
}
