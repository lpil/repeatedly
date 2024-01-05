export function call(delayMs, fun) {
  let i = 0;
  return setInterval(() => {
    fun(i);
    i += 1;
  }, delayMs);
}

export function stop(intervalId) {
  clearInterval(intervalId);
}
