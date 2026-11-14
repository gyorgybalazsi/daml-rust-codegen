# List available recipes
default:
    @just --list

# Generate Rust types from DAR file(s)
# Usage: just codegen output.rs path/to/file.dar [path/to/other.dar ...]
codegen output +dars:
    cargo run --release -- --dar {{dars}} -o {{output}}

# Build the example DARs the tests read (needs dpm on PATH)
build-dars:
    cd _daml/daml-ticketoffer && dpm build --all
    cd _daml/daml-nested-test && dpm build --all

# Build the example DARs, then run the tests (they regenerate generated/*.rs)
test: build-dars
    cargo test
