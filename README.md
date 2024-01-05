# repeatly

Call a function repeatedly with a number of milliseconds between each call.

[![Package Version](https://img.shields.io/hexpm/v/repeatly)](https://hex.pm/packages/repeatly)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/repeatly/)

Works on both Erlang and JavaScript runtimes!

```sh
gleam add repeatly
```
```gleam
import repeatly

pub fn main() {
  // Print every 500ms
  let repeater = repeatedly.call(500, fn(i) {
    io.println("Call number " <> int.to_string(i))
  })

  // And at some point later, stop it
  repeatedly.stop(repeater)
}
```

Further documentation can be found at <https://hexdocs.pm/repeatly>.

