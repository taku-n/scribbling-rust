# Chapter 2

## コメント

```rust
use anyhow::*;

#[tokio::main]
async fn main() -> Result<()> {
    // This is a comment

    //Err(anyhow!("Omg!"))
    Ok(())
}
```

## 可変変数

```rust
use anyhow::*;

#[tokio::main]
async fn main() -> Result<()> {
    let mut x = 57;

    //Err(anyhow!("Omg!"))
    Ok(())
}
```

## if

```rust
use anyhow::*;

#[tokio::main]
async fn main() -> Result<()> {
    let mut x = 1;

    if x == 1 {
        dbg!("x is 1");
    } else if x == 2 {
        dbg!("x is 2");
    } else {
        dbg!("x is not 1 or 2");
    }

    //Err(anyhow!("Omg!"))
    Ok(())
}
```

```no_compile
[src/main.rs:8] "x is 1" = "x is 1"
```

## for 1

```rust
use anyhow::*;

#[tokio::main]
async fn main() -> Result<()> {
    for x in 1..=5 {
        dbg!(x);
    }

    //Err(anyhow!("Omg!"))
    Ok(())
}
```

```no_compile
[src/main.rs:6] x = 1
[src/main.rs:6] x = 2
[src/main.rs:6] x = 3
[src/main.rs:6] x = 4
[src/main.rs:6] x = 5
```

## ベクター

```rust
use anyhow::*;

#[tokio::main]
async fn main() -> Result<()> {
    let mut v = vec![1, 2, 3, 4, 5];

    //Err(anyhow!("Omg!"))
    Ok(())
}
```

## for 2

```rust
use anyhow::*;

#[tokio::main]
async fn main() -> Result<()> {
    let mut v = vec![1, 2, 3, 4, 5];

    for x in v {
        dbg!(x);
    }

    //Err(anyhow!("Omg!"))
    Ok(())
}
```

```no_compile
[src/main.rs:8] x = 1
[src/main.rs:8] x = 2
[src/main.rs:8] x = 3
[src/main.rs:8] x = 4
[src/main.rs:8] x = 5
```

さて、ここまではよくあるプログラミング言語という感じかと思いますが、つぎの例では Rust らしさが見えます  

```rust, compile_fail
use anyhow::*;

#[tokio::main]
async fn main() -> Result<()> {
    let mut v = vec![1, 2, 3, 4, 5];

    for x in v {
        dbg!(x);
    }

    dbg!(v);  // (1)

    //Err(anyhow!("Omg!"))
    Ok(())
}
```

```no_compile
error[E0382]: use of moved value: `v`
  --> src/main.rs:11:10
   |
5  |     let mut v = vec![1, 2, 3, 4, 5];
   |         ----- move occurs because `v` has type `Vec<i32>`, which does not implement the `Copy` trait
6  |
7  |     for x in v {
   |              - `v` moved due to this implicit call to `.into_iter()`
...
11 |     dbg!(v);
   |          ^ value used here after move
   |
note: `into_iter` takes ownership of the receiver `self`, which moves `v`
  --> /rustc/cc66ad468955717ab92600c770da8c1601a4ff33/library/core/src/iter/traits/collect.rs:267:18
help: consider iterating over a slice of the `Vec<i32>`'s content to avoid moving into the `for` loop
   |
7  |     for x in &v {
   |              +

For more information about this error, try `rustc --explain E0382`.
```

(1) のところでコンパイルエラーです  
for でベクターを使ったあと、さらにベクターを使うことができません  
こちらはいまのところ解消できませんので、先へ進みます  

## ブロック

```rust
use anyhow::*;

#[tokio::main]
async fn main() -> Result<()> {
    async {
        dbg!("hello, block");
    }.await;

    //Err(anyhow!("Omg!"))
    Ok(())
}
```

```no_compile
[src/main.rs:6] "hello, block" = "hello, block"
```

## 関数

2つ の整数で掛け算をし、その答えを返す関数 multiply() をつくります  

```rust
use anyhow::*;

#[tokio::main]
async fn main() -> Result<()> {
    let mut answer;

    answer = multiply(3, 19).await;

    dbg!(answer);

    //Err(anyhow!("Omg!"))
    Ok(())
}

async fn multiply(x: i32, y: i32) -> i32 {
    let mut z;

    z = x * y;

    z
}
```

```no_compile
[src/main.rs:9] answer = 57
```

こちらではじめて i32型 が出てきました  
i32型 は 32bit の符号付き整数型です  
型を推論できない整数リテラルも i32型 になります  
() の中の引数名の後ろに引数の型を書き、-> の後ろに返り値の型を書きます  
返り値がない関数の場合、-> と返り値の型は省略できます  
たとえば async fn hello() {} と書けます  

行末にセミコロンが付いている行が 文  
行末にセミコロンが付いていない行が 式 です  
そして、関数の最後にある式の値が関数の返り値になります  
つまり multiply() では z です  
また main() の返り値が最後にある式である  
Ok(()) や  
Err(anyhow!("Omg!")) であったこともわかります  
返り値がない関数では、最後の式を省略できます  

Result<()> にある () は ユニット型 です  
Ok(()) にもある () という値だけを入れることができます  

関数を呼び出したあと await を付けて実行します  

## モジュール

main.rs をつぎのようにします  

```rust, compile_fail
mod mod1;
mod mod2;

use anyhow::*;

#[tokio::main]
async fn main() -> Result<()> {
    mod1::mod1f().await;
    mod2::mod21::mod21f().await;

    //Err(anyhow!("Omg!"))
    Ok(())
}
```

main.rs 以外をつぎのようにします  

```no_compile
.
|-- main.rs
|-- mod1.rs      -- pub async fn mod1f() { dbg!("mod1"); }
|-- mod2
|   `-- mod21.rs -- pub async fn mod21f() { dbg!("mod21"); }
`-- mod2.rs      -- pub mod mod21;
```

```no_compile
$ cargo run
```

```no_compile
[src/mod1.rs:1] "mod1" = "mod1"
[src/mod2/mod21.rs:1] "mod21" = "mod21"
```
### mod 間で呼ぶ

```no_compile
.
|-- main.rs
|-- mod1.rs
`-- mod2.rs
```

main.rs  

```no_compile
mod mod1;
mod mod2;
```

mod1.rs  

```no_compile
use super::mod2;

mod2::mod2f();
```

mod2.rs  

```no_compile
pub async fn mod2f() {}
```

## クレート

ライブラリーをつくります  

```no_compile
$ cargo new --lib hellocrate
$ cd hellocrate
```

Cargo.toml の [dependencies] の下に、つぎの 2行 を追加します  

```no_compile
tokio = { version = "1", features = ["full"] }
anyhow = { version = "1" }
```

src/lib.rs をつぎのようにします  

```rust
pub async fn hello() {
    dbg!("hello, crate");
}
```

呼び出してみます  
src/main.rs を追加して、つぎのようにします  

```rust, compile_fail
use anyhow::*;

#[tokio::main]
async fn main() -> Result<()> {
    hellocrate::hello().await;

    //Err(anyhow!("Omg!"))
    Ok(())
}
```

```no_compile
[src/lib.rs:2] "hello, crate" = "hello, crate"
```

外から使ってみます  
hellocrate の外に出ます  

```no_compile
$ cd ..
```

hellocrate を使う usehellocrate をつくります  

```no_compile
$ cargo new usehellocrate
$ cd usehellocrate
```

Cargo.toml の [dependencies] の下に、つぎの 3行 を追加します  

```no_compile
tokio = { version = "1", features = ["full"] }
anyhow = { version = "1" }
hellocrate = { path = "../hellocrate" }
```

src/main.rs をつぎのようにします  

```rust, compile_fail
use anyhow::*;

#[tokio::main]
async fn main() -> Result<()> {
    hellocrate::hello().await;

    //Err(anyhow!("Omg!"))
    Ok(())
}
```

最終的なファイル構成は、つぎのようになります  

```no_compile
.
|-- hellocrate
|   |-- Cargo.toml
|   `-- src
|       |-- lib.rs
|       `-- main.rs
|
`-- usehellocrate
    |-- Cargo.toml -- hellocrate = { path = "../hellocrate" }
    `-- src
        `-- main.rs
```

実行します  

```no_compile
$ cargo run
```

```no_compile
[/home/user/hellocrate/src/lib.rs:2] "hello, crate" = "hello, crate"
```

じつは、いままで cargo new してきたものも、すべてクレートです  
cargo new はクレートをつくります  
そして  
バイナリーをつくりたいときには main.rs  
ライブラリーをつくりたいときには lib.rs を  
使います  
cargo new のときに  
--lib がないときは main.rs のテンプレートを  
--lib があるときは lib.rs のテンプレートを  
つくってくれますが、つくってくれなかった方を自分でつくれば --lib があってもなくても違いはありません  

自身のクレートを指し示したいときは固有のクレート名は使いません  
crate を使います  
たとえば multiply() は、つぎのようにしても動きます  

```rust
use anyhow::*;

#[tokio::main]
async fn main() -> Result<()> {
    let mut answer;

    answer = crate::multiply(3, 19).await;

    dbg!(answer);

    //Err(anyhow!("Omg!"))
    Ok(())
}

async fn multiply(x: i32, y: i32) -> i32 {
    let mut z;

    z = x * y;

    z
}
```

crate::multiply() は自身のクレートの multiply() であることを明示しています  

例外として、lib.rs があり、同じディレクトリの main.rs から呼び出す場合、固有のクレート名を使います  
外から呼び出せるかを中から試せるようになっているというイメージです  

以降このドキュメントではクレートのルートディレクトリを crate で表すことにします  
たとえば main.rs は crate/src/main.rs です  

固有のクレート名とは Cargo.toml の [package] の name です  
この name は crate/target/debug につくられるバイナリーや静的ライブラリーの名前になります  
たとえば name が hello なら  
バイナリーが crate/target/debug/hello  
静的ライブラリーが crate/target/debug/libhello.rlib  
となります  

ちなみに crate/target/debug/libhello.d は Makefile です  
