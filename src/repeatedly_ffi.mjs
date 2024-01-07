class Repeater {
  constructor(delayMs, fun) {
    this.fun = fun;
    this.i = 0;
    this.intervalId = setInterval(() => {
      this.tick();
    }, delayMs);
  }

  tick() {
    this.fun(this.i);
    this.i += 1;
  }
}

export function call(delayMs, fun) {
  return new Repeater(delayMs, fun);
}

export function stop(repeater) {
  clearInterval(repeater.intervalId);
}

export function replace(repeater, fun) {
  repeater.fun = fun;
}
