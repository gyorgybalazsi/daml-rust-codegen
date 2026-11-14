# daml-rust-codegen

Generates Rust types from Daml DAR packages: one struct per template and choice
record, plus the nested records, variants, enums, type aliases, and generic
types they use, laid out in modules that mirror the Daml packages and modules.

The generated code targets the Canton Ledger API v2 and uses three crates from
[rust-canton-toolbox](https://github.com/gyorgybalazsi/rust-canton-toolbox):
`ledger-api` (gRPC bindings), `daml-type-rep` (Daml built-in types and the
`LapiAccess` / `ToCreateArguments` traits), and `derive-lapi-access` (the derive
macros). The toolbox's `test` crate is a worked example of using it.

This project was split out of rust-canton-toolbox, with its history.

## Prerequisites

- Rust (the version is pinned in `rust-toolchain.toml`)
- **[protoc](https://protobuf.dev/installation/)**, used by the build script
- Network access on a clean build: `build.rs` downloads the Daml-LF protos for
  the Canton version in `daml-sdk-version` (currently 3.7.1) and compiles them
- **Daml SDK** with `dpm`, only to build the example DARs for the tests
- **[just](https://github.com/casey/just)** (optional)

## Usage

```
cargo run --release -- --dar path/to/model.dar -o model.rs
```

Pass `--dar` more than once to generate code for several DARs into one file
(`just codegen model.rs a.dar b.dar` does the same).

To use the output, add the crates it depends on to your project:

```toml
[dependencies]
ledger-api = { git = "https://github.com/gyorgybalazsi/rust-canton-toolbox" }
daml-type-rep = { git = "https://github.com/gyorgybalazsi/rust-canton-toolbox" }
derive-lapi-access = { git = "https://github.com/gyorgybalazsi/rust-canton-toolbox" }
serde = { version = "1", features = ["derive"] }
```

and include the file, for example with `include!("model.rs");` or by
copying it into `src/`.

## Example output

`generated/` holds the output for the two example Daml projects in `_daml/`
(`daml-ticketoffer` and `daml-nested-test`). The tests regenerate these files,
so a diff there after `just test` shows how a change affects the output.

## Tests

The tests read the example DARs, so build them first:

```
just test          # builds the DARs with dpm, then runs cargo test
```

## License

Licensed under either of

- Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE) or <http://www.apache.org/licenses/LICENSE-2.0>)
- MIT license ([LICENSE-MIT](LICENSE-MIT) or <http://opensource.org/licenses/MIT>)

at your option.

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall be
dual licensed as above, without any additional terms or conditions.
