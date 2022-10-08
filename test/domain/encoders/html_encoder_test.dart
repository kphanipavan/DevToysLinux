import 'package:devtoys/domain/helpers/encoders/html_encoder.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HTML Encoder', () {
    var encoder = HTMLEncoder();
    test("Encode HTML", () {
      String input = "<h1>test</h1>";
      String expectedResult = "&lt;h1&gt;test&lt;&#47;h1&gt;";

      String result = encoder.encode(input);

      expect(expectedResult, result);
    });
    test("Decode HTML", () {
      String input = "&lt;h1&gt;test&lt;&#47;h1&gt;";
      String expectedResult = "<h1>test</h1>";

      String result = encoder.decode(input);

      expect(expectedResult, result);
    });
  });
}