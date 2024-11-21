import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/counter/counter.dart';

// void main() {
//   group("Counter", () {
//     test(
//       "inital value should be 0",
//       () {
//         final Counter counter = Counter();
//         expect(counter.count, 0);
//       },
//     );
//     test(
//       "Should Increment value",
//       () {
//         final Counter counter = Counter();
//         counter.add();
//         expect(counter.count, 1);
//       },
//     );
//     test(
//       "Should decrement value",
//       () {
//         final Counter counter = Counter();
//         counter.sub();
//         expect(counter.count, -1);
//       },
//     );
//   });
// }

//setup() /setupAll() and tearDown() /tearDownAll() methods

//example of setup() method
// void main() {
//   group("Counter", () {
//     late Counter counter;

//     //here the setUp() method is called before each test
//     setUp(() {
//       counter = Counter();
//     });

//     test(
//       "inital value should be 0",
//       () {
//         final Counter counter = Counter();
//         expect(counter.count, 0);
//       },
//     );
//     test(
//       "Should Increment value",
//       () {
//         counter.add();
//         expect(counter.count, 1);
//       },
//     );
//     test(
//       "Should decrement value",
//       () {
//         counter.sub();
//         expect(counter.count, -1);
//       },
//     );
//   });
// }

//example of setupAll() method

// void main() {
//   group("Counter", () {
//     late Counter counter;

//     //here the setUpAll() method is called before all tests
//     setUpAll(() {
//       counter = Counter();
//     });

//     test(
//       "inital value should be 0",
//       () {
//         expect(counter.count, 0);
//       },
//     );
//     test(
//       "Should Increment value",
//       () {
//         counter.add();
//         expect(counter.count, 1);
//       },
//     );
//     test(
//       "Should decrement value",
//       () {
//         counter.sub();
//         expect(counter.count, 0);
//       },
//     );
//   });
// }

//example of tearDown() method

// void main() {
//   group("Counter", () {
//     late Counter counter;

//     //here the setUp() method is called before each test
//     setUp(() {
//       counter = Counter();
//     });

//     //here the tearDown() method is called after each test
//     tearDown(() {
//       counter = Counter();
//     });

//     test(
//       "inital value should be 0",
//       () {
//         expect(counter.count, 0);
//       },
//     );
//     test(
//       "Should Increment value",
//       () {
//         counter.add();
//         expect(counter.count, 1);
//       },
//     );
//     test(
//       "Should decrement value",
//       () {
//         counter.sub();
//         expect(counter.count, 0);
//       },
//     );
//   });
// }

//example of tearDownAll() method

void main() {
  group("Counter", () {
    late Counter counter;

    //here the setUpAll() method is called before all tests
    setUpAll(() {
      counter = Counter();
    });

    //here the tearDownAll() method is called after all tests
    tearDownAll(() {
      counter = Counter();
    });

    test(
      "inital value should be 0",
      () {
        expect(counter.count, 0);
      },
    );
    test(
      "Should Increment value",
      () {
        counter.add();
        expect(counter.count, 1);
      },
    );
    test(
      "Should decrement value",
      () {
        counter.sub();
        expect(counter.count, 0);
      },
    );
  });
}
