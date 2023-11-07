# なぐりがき Rust

## hello, world

hello, world をしましょう。  
まずは hello プロジェクトをつくって中に入ります。  

```no_compile
$ cargo new hello
$ cd hello
```

Cargo.toml をつぎのように編集します。

```no_compile
[package]
name = "hello"
version = "0.1.0"
edition = "2021"

[dependencies]
tokio = { version = "1", features = ["full"] }
anyhow = { version = "1" }
```

src/main.rs をつぎのように編集します。  

```rust
use anyhow::*;

#[tokio::main]
async fn main() -> Result<()> {
    dbg!("hello, world");
    //Err(anyhow!("Omg!"))
    Ok(())
}
```

実行します。

```no_compile
$ cargo run
```
