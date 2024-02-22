import repeatedly
import gleam/io
import gleam/int

pub fn main() {
  let repeater =
    repeatedly.call(250, 0, fn(x, i) {
      // Here we go!
      io.println(int.to_string(x) <> int.to_string(i))
      x - 1
    })

  repeatedly.call(800, Nil, fn(_, _) {
    io.println("set function")
    repeatedly.set_function(repeater, fn(x, i) {
      io.println(int.to_string(x) <> int.to_string(i * 100))
      x - 1
    })
  })

  repeatedly.call(800, Nil, fn(_, _) {
    io.println("update state")
    repeatedly.update_state(repeater, fn(x) { x * 1000 })
  })

  repeatedly.call(5000, Nil, fn(_, _) {
    io.println("Sending stop")
    repeatedly.stop(repeater)

    // Stop again to ensure that calling it multiple times is safe
    repeatedly.stop(repeater)
  })

  sleep(10_000)
}

@external(erlang, "timer", "sleep")
fn sleep(_ms: Int) -> Nil {
  Nil
}
