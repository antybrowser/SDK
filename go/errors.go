package antybrowser

import "fmt"

// AntyBrowserError is returned when the API returns an error response.
type AntyBrowserError struct {
	Message      string
	StatusCode   int
	ResponseBody string
}

func (e *AntyBrowserError) Error() string {
	return fmt.Sprintf("%s (status %d)", e.Message, e.StatusCode)
}
