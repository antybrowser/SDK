# Publishing to NuGet.org

Follow these instructions to publish the `AntyBrowser.SDK` package to [NuGet.org](https://www.nuget.org/).

## Prerequisites

1.  **NuGet Account**: Create an account on [NuGet.org](https://www.nuget.org/).
2.  **API Key**: Generate an API key from [NuGet.org API Keys page](https://www.nuget.org/account/apikeys).
3.  **dotnet CLI**: Ensure you have the .NET SDK installed.

## Method 1: Automated Release (VS Code)

I have configured a VS Code task to automate the release process. 

1.  Edit the `.env` file in `sdk/nuget/AntyBrowser.SDK/.env` to set your desired `VERSION` and `NUGET_API_KEY`.
2.  Open the Command Palette (`Ctrl+Shift+P`).
3.  Type `Tasks: Run Task`.
4.  Select `Release Antybrowser SDK`.

This task will:
- Update the version in `AntyBrowser.SDK.csproj`.
- Pack the project in Release mode.
- Push the package to NuGet.org using the API key from your `.env` file.

## Method 2: Manual Release

### Step 1: Pack the Project

Run the following command in the `sdk/nuget/AntyBrowser.SDK` directory:

```bash
dotnet pack -c Release
```

### Step 2: Push to NuGet.org

Replace `<YOUR_API_KEY>` with your actual NuGet API key and run:

```bash
dotnet nuget push bin/Release/AntyBrowser.SDK.<VERSION>.nupkg --api-key <YOUR_API_KEY> --source https://api.nuget.org/v3/index.json
```

---

### Tips for Success

- **Check Versioning**: NuGet uses Semantic Versioning (SemVer). Use `major.minor.patch`.
- **Verify Dependencies**: Ensure all referenced packages are stable.
- **Review Metadata**: Make sure the metadata is correct in the `.csproj` before packing.
