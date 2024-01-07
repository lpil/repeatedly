pub type Repeater

/// Call a function every specified number of milliseconds, waiting the number
/// of milliseconds before the first call.
///
@external(erlang, "repeatedly_ffi", "call")
@external(javascript, "./repeatedly_ffi.mjs", "call")
pub fn call(delay_ms: Int, function: fn(Int) -> a) -> Repeater

/// Stop the repeater, preventing it from triggering again.
///
/// On Erlang if the repeater message queue is not empty then this message will
/// handled after all other messages.
///
/// On JavaScript there is no message queue so it will stop immediately, though
/// not interrupt the function callback if currently being executed.
///
@external(erlang, "repeatedly_ffi", "stop")
@external(javascript, "./repeatedly_ffi.mjs", "stop")
pub fn stop(repeater: Repeater) -> Nil

/// Replace the function being called by a repeater.
///
/// On Erlang if the repeater message queue is not empty then this message will
/// handled after all other messages.
///
/// On JavaScript there is no message queue so it will stop immediately, though
/// not interrupt the function callback if currently being executed.
///
@external(erlang, "repeatedly_ffi", "replace")
@external(javascript, "./repeatedly_ffi.mjs", "replace")
pub fn replace(repeater: Repeater, function: fn(Int) -> a) -> Nil
