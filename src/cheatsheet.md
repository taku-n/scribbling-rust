# Cheat Sheet

## main 関数

```no_compile
$ cargo add tokio@1 --features="full"
$ cargo add anyhow@1
```

```rust
use anyhow::*;

#[tokio::main]
async fn main() -> Result<()> {


    //Err(anyhow!("Omg!"))
    Ok(())
}
```
