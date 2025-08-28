# Cheat Sheet

## main 関数

```no_compile
cargo add tokio@1 --features="full"
cargo add anyhow@1
cargo add async-recursion@1
```

```rust
use anyhow::*;
use async_recursion::*;

#[tokio::main]
async fn main() -> Result<()> {


    //Err(anyhow!("Omg!"))
    Ok(())
}

#[async_recursion]
async fn recursive() {
}
```

## アップデート

rustup 自身のアップデート  

```no_compile
rustup self update
```

Rust のアップデート  

```no_compile
rustup update
```

Cargo.toml の dependencies にあるクレートのアップデート  

```no_compile
cargo update
```
