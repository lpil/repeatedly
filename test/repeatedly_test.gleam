import repeatedly
import gleam/io
import gleam/int

pub fn main() {
  let repeater =
    repeatedly.call(500, fn(i) {
      // Here we go!
      io.println(int.to_string(i))
    })

  repeatedly.call(2000, fn(_) {
    io.println("Sending stop")
    repeatedly.stop(repeater)
  })

  sleep(10_000)
}

@external(erlang, "timer", "sleep")
fn sleep(_ms: Int) -> Nil {
  Nil
}
