import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/api_app/models/post_model.dart';
import 'package:flutter_testing/api_app/services/api_service.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'api_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group("Api Service", () {
    // Test 1 - Test the fetchPosts method success with 200 status code with a list of posts
    test(
        "Test the fetchPosts method success with 200 status code with a list of posts",
        () async {
      // Mock the http client Network call
      final client = MockClient();
      // Mock the response
      when(client.get(Uri.parse('https://jsonplaceholder.typicode.com/posts')))
          .thenAnswer(
        (_) async =>
            http.Response('[{"id": 1, "title": "Title", "body": "Body"}]', 200),
      );

      // expect function to test the result here we are testing the fetchPosts method
      expect(await ApiService(client).fetchPosts(), isA<List<Post>>());
    });

    // Test 2 - Test the fetchPosts method failed with other status code with an exception
    test(
        "Test the fetchPosts method failed with other status code with an exception",
        () async {
      // Mock the http client Network call
      final client = MockClient();
      // Mock the response
      when(client.get(Uri.parse('https://jsonplaceholder.typicode.com/posts')))
          .thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );

      // expect function to test the result here we are testing the fetchPosts method
      expect(ApiService(client).fetchPosts(), throwsException);
    });
  });
}
