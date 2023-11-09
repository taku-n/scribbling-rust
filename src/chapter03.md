# Chapter 3

## rustup

rustup 自身のアップデート  

```no_compile
$ rustup self update
```

Rust のアップデート

```no_compile
$ rustup update
```

## Cargo

これまで Cargo.toml の dependencies に直接追加してきましたが、コマンドでできます  

```no_compile
$ cargo new cargoadd
$ cd cargoadd
$ cargo add tokio@1 --features="full"
$ cargo add anyhow@1
$ cat Cargo.toml
```

```no_compile
[package]
name = "cargoadd"
version = "0.1.0"
edition = "2021"

# See more keys and their definitions at https://doc.rust-lang.org/cargo/reference/manifest.html

[dependencies]
anyhow = "1"
tokio = { version = "1", features = ["full"] }
```

また dependencies にあるクレートをつぎのコマンドでアップデートできます  

```no_compile
$ cargo update
```

## 単体テスト

```no_compile
$ cargo new testtest
$ cd testtest
$ cargo add tokio@1 --features="full"
$ cargo add anyhow@1
```

main.rs をつぎのようにします  

```rust
use anyhow::*;

#[tokio::main]
async fn main() -> Result<()> {
    dbg!(multiply(3, 19).await);

    //Err(anyhow!("Omg!"))
    Ok(())
}

async fn multiply(x: i32, y: i32) -> i32 {
    x * y
}
```

```no_compile
$ cargo run
```

```no_compile
[src/main.rs:5] multiply(3, 19).await = 57
```

テストを実行します  

```no_compile
$ cargo test
```

```no_compile
running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s
```

テストコードを書いていないのでなにも実行されません  

まず cargo test のときのみ実行されるコードを書きます  
main.rs をつぎのようにします  

```rust
use anyhow::*;

#[tokio::main]
async fn main() -> Result<()> {
    dbg!(multiply(3, 19).await);

    //Err(anyhow!("Omg!"))
    Ok(())
}

async fn multiply(x: i32, y: i32) -> i32 {
    x * y
}

#[cfg(test)]
mod tests {
}
```

#[cfg(test)] によって tests モジュールは cargo test のときのみ実行されます  
tests モジュールの中にテストしたい関数を書きます  

```rust
#[cfg(test)]
mod tests {
    #[tokio::test]
    async fn test_multiply() {
    }
}
```

#[tokio::test] を書くことによって直後の関数をテストすることができます  
テスト内容を書いていきます  

```rust
use anyhow::*;

#[tokio::main]
async fn main() -> Result<()> {
    dbg!(multiply(3, 19).await);

    //Err(anyhow!("Omg!"))
    Ok(())
}

async fn multiply(x: i32, y: i32) -> i32 {
    x * y
}

#[cfg(test)]
mod tests {
    #[tokio::test]
    async fn test_multiply() {
        assert!(crate::multiply(3, 19).await == 57);
    }
}
```

assert!() の中身が成り立っていればテストを正常に通過します  

```no_compile
$ cargo test
```

```no_compile
running 1 test
test tests::test_multiply ... ok

test result: ok. 1 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.01s
```
