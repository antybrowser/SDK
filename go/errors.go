package antybrowser

import "fmt"

// AntybrowserError is returned when the API returns an error response.
type AntybrowserError struct {
	Message      string
	StatusCode   int
	ResponseBody string
}

func (e *AntybrowserError) Error() string {
	return fmt.Sprintf("%s (status %d)", e.Message, e.StatusCode)
}
