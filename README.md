# なぐりがき Rust

## hello, world

hello, world をしましょう。まずは hello プロジェクトをつくって中に入ります。  

```
$ cargo new hello
$ cd hello
```

Cargo.toml をつぎのように編集します。

```
[package]
name = "hello"
version = "0.1.0"
edition = "2021"

[dependencies]
tokio = { version = "1", features = ["full"] }
```

src/main.rs をつぎのように編集します。

```Rust
#[tokio::main]
async fn main() -> std::process::ExitCode {
    dbg!("hello, world");

    std::process::ExitCode::from(0)
}
```

実行します。

```
$ cargo run
```

定数版の ExitCode と panic!() 時のコード
ドキュメントテストでテストできるような形で HTML で見れるように GitHub Pages を使って
