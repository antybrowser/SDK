#pragma once

#include <stdexcept>
#include <string>

namespace antybrowser {

class AntybrowserError : public std::runtime_error {
public:
    AntybrowserError(const std::string& message, int status_code = 0,
                     const std::string& response_body = "")
        : std::runtime_error(message),
          status_code_(status_code),
          response_body_(response_body) {}

    int status_code() const noexcept { return status_code_; }
    const std::string& response_body() const noexcept { return response_body_; }

private:
    int status_code_;
    std::string response_body_;
};

} // namespace antybrowser
