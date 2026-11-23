# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2026-11-23

The first release of daml-rust-codegen as a standalone crate. It generates Rust
types from Daml DAR packages for use with the Canton Ledger API v2.

### Added
- Standalone `daml-rust-codegen` crate and CLI
  (`cargo run --release -- --dar model.dar -o model.rs`), split out of
  rust-canton-toolbox (now canton-event-graph-syncer) with its history. It has
  its own README, justfile, CI workflow and `Cargo.lock`.
- Generates one struct per template and choice record, plus the nested records,
  variants, enums, type aliases and generic types they use, in modules that
  mirror the Daml packages and modules. Several DARs can go into one file.
- `ledger-api` and `daml-type-rep` come as git dependencies from
  canton-event-graph-syncer.

### Changed
- Daml examples and the Daml-LF protos moved to SDK / Canton 3.7.1.
- Pinned `ledger-api` and `daml-type-rep` to canton-event-graph-syncer 0.1.0
  (129c642, tonic 0.14). They were on 170bbdb, from before tonic 0.14.
- Updated prost, prost-build and prost-types to 0.14, zip to 9.6, syn to 3 and
  prettyplease to 0.3. A DAR entry whose name can't be read now fails with an
  error naming the entry.

### Security
- Added `SECURITY.md`: report vulnerabilities privately through GitHub.
- The CI workflow's token is limited to `contents: read`.
- Dependabot opens weekly grouped updates for Cargo and GitHub Actions (but
  not for the pinned Rust toolchain action).

[Unreleased]: https://github.com/gyorgybalazsi/daml-rust-codegen/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/gyorgybalazsi/daml-rust-codegen/releases/tag/v0.1.0
