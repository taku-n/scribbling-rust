# なぐりがき Rust

## Chapter 1

### hello, world

hello, world をしましょう  
まずは hello プロジェクトをつくって中に入ります  

```no_compile
$ cargo new hello
$ cd hello
```

Cargo.toml をつぎのように編集します  
[dependencies] の下に 2行 追加するだけです  

```no_compile
[package]
name = "hello"
version = "0.1.0"
edition = "2021"

[dependencies]
tokio = { version = "1", features = ["full"] }
anyhow = { version = "1" }
```

src/main.rs をつぎのように編集します  
インデントはスペース 4つ です  

```rust
use anyhow::*;

#[tokio::main]
async fn main() -> Result<()> {
    dbg!("hello, world");
    //Err(anyhow!("Omg!"))
    Ok(())
}
```

実行します  

```no_compile
$ cargo run
[src/main.rs:5] "hello, world" = "hello, world"
```

このときの終了コードはなんでしょうか  

```no_compile
$ echo $?
0
```

今度はつぎのようにしてみます  

```rust, should_panic
use anyhow::*;

#[tokio::main]
async fn main() -> Result<()> {
    dbg!("hello, world");
    Err(anyhow!("Omg!"))
    //Ok(())
}
```

実行します  

```no_compile
$ cargo run
[src/main.rs:5] "hello, world" = "hello, world"
Error: Omg!
```

エラーが発生したことが確認できます  
終了コードはなんでしょうか  

```no_compile
$ echo $?
1
```

このように、POSIX 環境では最後に  
Ok を返すと終了コードは 0  
Err を返すと終了コードは 1 と  
なることがわかります  

これでシェルとの最低限のやりとりができます  

ちなみにバイナリは target/debug/hello ですがリリースビルドしたければ

```no_compile
$ cargo build --release
```

とすれば target/release/hello が手に入ります

### hello, world を除く

ここで hello, world を除いたコードを確認したいと思います  
つぎのようになります  

```rust
use anyhow::*;

#[tokio::main]
async fn main() -> Result<()> {
    //Err(anyhow!("Omg!"))
    Ok(())
}
```

おまじないだらけですが、こちらが今後のベースとなります  

いまは  
main() の下から実行されること  
Ok を返すことで成功 (0) を  
Err を返すことで失敗 (1) とエラーメッセージを  
シェルに伝えることができることがわかれば十分です  
