# Publishing to Go Modules

## Prerequisites

1. **GitHub repo**: The Go module path is `github.com/antybrowser/SDK/go`
2. **Git tag**: Go modules are versioned via git tags

## Steps

1. Push the `sdk/go/` directory to GitHub:
   ```bash
   git add sdk/go/
   git commit -m "Add Go SDK"
   git push
   ```

2. Tag the release:
   ```bash
   git tag sdk/go/v1.0.1
   git push origin sdk/go/v1.0.1
   ```

3. Users install with:
   ```bash
   go get github.com/antybrowser/SDK/go@v1.0.1
   ```

## Version Bumps

```bash
# Edit version references, then:
git tag sdk/go/v1.0.2
git push origin sdk/go/v1.0.2
```

## Verify

```bash
go list -m github.com/antybrowser/SDK/go@latest
```
