# XcodeBuildMCP iOS Template

This repository contains the iOS project template used by [XcodeBuildMCP](https://github.com/cameroncooke/XcodeBuildMCP)'s `scaffold_ios_project` tool.

## Overview

This template provides a modern iOS project structure with:
- Workspace + Swift Package architecture
- Xcode 16's buildable folders for automatic file discovery
- Centralized build configuration via XCConfig files
- Clean separation between app shell and feature code

## Usage

This template is automatically downloaded and used by XcodeBuildMCP when you run:
```bash
scaffold_ios_project({ projectName: "MyApp", outputPath: "/path/to/output" })
```

## Versioning

Each release of this template is versioned and tagged. XcodeBuildMCP downloads specific versions to ensure compatibility.

## Development

To work on this template locally:

1. Clone this repository
2. Make your changes
3. Set the `XCODEBUILD_MCP_IOS_TEMPLATE_PATH` environment variable in your MCP configuration to point to your local clone
4. XcodeBuildMCP will use your local version instead of downloading from GitHub

## Contributing

Please ensure any changes maintain compatibility with XcodeBuildMCP's scaffolding system. Test your changes by creating a new project using the local template override.

## License

This template is part of XcodeBuildMCP and follows the same license terms.