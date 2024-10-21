# Changelog

## v2.1.1 - 2024-09-21

- Fixed a bug where the repeated function could change the type of the state,
  resulting in data corruption.

## v2.1.1 - 2024-02-22

- Fixed a bug where calling the stop function multiple times would cause a crash
  on Erlang.

## v2.1.0 - 2024-01-08

- Added the `update_state` function.

## v2.0.1 - 2024-01-07

- Stopping is now synchronous on Erlang.

## v2.0.0 - 2024-01-07

- The repeater now holds a state value which can be updated on each iteration.
- Added the `set_function` and `set_state` functions.

## v1.0.0 - 2024-01-05

- Initial release
