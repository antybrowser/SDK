package antybrowser_test

import (
	"testing"

	antybrowser "github.com/AntyBrowser/AntyBrowser.SDK/go"
)

func TestNewClient(t *testing.T) {
	c := antybrowser.NewClient("test_key")
	if c == nil {
		t.Fatal("expected non-nil client")
	}
}

func TestNewClientWithPort(t *testing.T) {
	c := antybrowser.NewClient("test_key", antybrowser.WithPort(5174))
	if c == nil {
		t.Fatal("expected non-nil client")
	}
}
