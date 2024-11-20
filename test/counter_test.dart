import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/counter.dart';

void main() {
  group("Counter", () {
    test(
      "inital value should be 0",
      () {
        final Counter counter = Counter();
        expect(counter.count, 0);
      },
    );
    test(
      "Should Increment value",
      () {
        final Counter counter = Counter();
        counter.add();
        expect(counter.count, 1);
      },
    );
    test(
      "Should decrement value",
      () {
        final Counter counter = Counter();
        counter.sub();
        expect(counter.count, -1);
      },
    );
  });
}
