git clone --branch v13.0.0 https://github.com/bytecodealliance/wasmtime
cd wasmtime
git submodule update --init
cargo build --release --manifest-path crates/c-api/Cargo.toml
dart run ffigen  --compiler-opts '-Iwasmtime/crates/c-api/include/ -Iwasmtime/crates/c-api/wasm-c-api/include/'
