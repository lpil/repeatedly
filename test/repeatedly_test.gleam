import repeatedly
import gleam/io
import gleam/int

pub fn main() {
  let repeater =
    repeatedly.call(250, fn(i) {
      // Here we go!
      io.println(int.to_string(i))
    })

  repeatedly.call(800, fn(_) {
    io.println("Sending replace 1")
    repeatedly.replace(repeater, fn(i) { io.println(int.to_string(i * 100)) })
  })

  repeatedly.call(1200, fn(_) {
    io.println("Sending replace 2")
    repeatedly.replace(repeater, fn(i) { io.println(int.to_string(i)) })
  })

  repeatedly.call(5000, fn(_) {
    io.println("Sending stop")
    repeatedly.stop(repeater)
  })

  sleep(10_000)
}

@external(erlang, "timer", "sleep")
fn sleep(_ms: Int) -> Nil {
  Nil
}
