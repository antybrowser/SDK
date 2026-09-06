# Publishing @antybrowser/sdk to npm

## Prerequisites

1. **npm account**: Create one at [npmjs.com](https://www.npmjs.com/)
2. **npm CLI**: `npm install -g npm` (ensure latest)
3. **npm org**: Create the `@antybrowser` org on npm (one-time)

## Step 1: Login

```bash
npm login --scope=@antybrowser
```

This authenticates your npm account for the `@antybrowser` scope.

## Step 2: Build

```bash
cd sdk/npm
npm install
npm run build
```

## Step 3: Publish

```bash
npm publish --access public
```

The `--access public` flag is required for scoped packages on first publish.

## Version Bumps

```bash
# Patch (1.0.0 -> 1.0.1) — bug fixes
npm version patch

# Minor (1.0.0 -> 1.1.0) — new features, backward-compatible
npm version minor

# Major (1.0.0 -> 2.0.0) — breaking changes
npm version major

# Then publish
npm publish --access public
```

## Verify

After publishing, verify at: https://www.npmjs.com/package/@antybrowser/sdk

## Install from consumer side

```bash
npm install @antybrowser/sdk
```
