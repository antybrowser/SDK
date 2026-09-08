unit module Antybrowser::SDK::Error;

class AntybrowserError is Exception is export {
    has Str $.message;
    has Int $.status-code;
    has Str $.response-body;

    method new(Str :$message = '', Int :$status-code, Str :$response-body) {
        self.bless(:message($message), :status-code($status-code), :response-body($response-body));
    }

    method gist() {
        my $msg = "AntybrowserError: $!message";
        $msg ~= " (HTTP $!status-code)" if $!status-code.defined;
        $msg ~= "\nResponse: $!response-body" if $!response-body.defined;
        $msg;
    }
}
