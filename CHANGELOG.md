# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- ADR 001: Software Publishing Rules documentation in `docs/001-Software-Publishing/`
- CHANGELOG.md file to track project changes

### Changed
- Updated README.md Origin and Ownership sections for clarity and consistency
- Improved formatting in Origin section with bold text for organization name
- Renamed "Current repository" section to "Ownership" for better clarity

## [1.0.0] - 2025-09-24

### Added
- Initial clean fork from https://github.com/buerokratt/DataMapper
- Docker Compose v2 setup
- Handlebars DSL to REST endpoint mapping
- Health check endpoint at `/healthz`
- Sample DSL files in `DSL/samples/`
- Custom Handlebars helpers in `lib/helpers.js`

[Unreleased]: https://github.com/Buerostack/DataMapper/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/Buerostack/DataMapper/releases/tag/v1.0.0
