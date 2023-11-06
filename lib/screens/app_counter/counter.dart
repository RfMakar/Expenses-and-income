class Counter {
  int value;
  Counter(this.value);

  void inc() {
    value = value + 1;
  }

  void dec() {
    value = value - 1;
  }
}
