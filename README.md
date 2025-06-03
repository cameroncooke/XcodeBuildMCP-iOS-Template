# XcodeBuildMCP iOS Template

A modern iOS application template using a **workspace + SPM package** architecture for clean separation between app shell and feature code. This template is designed to be used with [XcodeBuildMCP](https://github.com/cameroncooke/XcodeBuildMCP).

## Features

- ✨ **Modern Architecture**: Workspace + Swift Package Manager structure
- 📦 **Clean Separation**: Minimal app shell with features in SPM package
- 🏗️ **Buildable Folders**: Xcode 16 support for automatic file discovery
- 🧪 **Test Ready**: Preconfigured with Swift Testing and XCUITest
- ⚙️ **XCConfig Based**: Build settings managed through configuration files
- 🚀 **AI-Friendly**: Designed for use with AI coding assistants

## Quick Start

### Using XcodeBuildMCP

The easiest way to use this template is through XcodeBuildMCP:

```bash
# Using the XcodeBuildMCP tool
mcp scaffold_ios_project --projectName "YourApp" --outputPath "./YourApp"
```

### Manual Download

You can also download the template directly from the [releases page](https://github.com/cameroncooke/XcodeBuildMCP-iOS-Template/releases).

## Template Structure

```
template/
├── Config/                         # XCConfig build settings
│   ├── Debug.xcconfig
│   ├── Release.xcconfig
│   ├── Shared.xcconfig
│   └── Tests.xcconfig
├── MyProject.xcworkspace/          # Workspace file
├── MyProject.xcodeproj/            # App shell project
├── MyProject/                      # App target (minimal)
│   ├── Assets.xcassets/
│   ├── MyProjectApp.swift
│   └── MyProject.xctestplan
├── MyProjectPackage/               # SPM package for features
│   ├── Package.swift
│   ├── Sources/
│   └── Tests/
└── MyProjectUITests/               # UI automation tests
```

## Customization

When using this template, the following placeholders will be replaced:

- `MyProject` → Your project name
- `com.example.MyProject` → Your bundle identifier
- `MyProjectFeature` → Your feature module name
- Build settings can be customized in the `Config/` XCConfig files

## Requirements

- Xcode 16.0 or later
- iOS 18.0+ deployment target (configurable)
- Swift 6.0

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This template is available under the MIT license. See the LICENSE file for more info.

## Related Projects

- [XcodeBuildMCP](https://github.com/cameroncooke/XcodeBuildMCP) - AI-powered Xcode build and development tools
- [XcodeBuildMCP macOS Template](https://github.com/cameroncooke/XcodeBuildMCP-macOS-Template) - macOS app template

---

Generated with ❤️ for the Swift community