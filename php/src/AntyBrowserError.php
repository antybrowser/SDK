<?php

declare(strict_types=1);

namespace Antybrowser\SDK;

final class AntybrowserError extends \RuntimeException
{
    public function __construct(
        string $message,
        public readonly ?int $statusCode = null,
        public readonly ?string $responseBody = null,
    ) {
        parent::__construct($message);
    }
}
