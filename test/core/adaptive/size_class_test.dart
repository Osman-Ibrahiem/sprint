import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/core/adaptive/size_class.dart';

void main() {
  group('SizeClass.fromWidth', () {
    final cases = <double, SizeClass>{
      0: SizeClass.compact,
      599: SizeClass.compact,
      600: SizeClass.medium,
      839: SizeClass.medium,
      840: SizeClass.expanded,
      1199: SizeClass.expanded,
      1200: SizeClass.large,
      2560: SizeClass.large,
    };
    cases.forEach((width, expected) {
      test('$width -> $expected', () {
        expect(SizeClass.fromWidth(width), expected);
      });
    });
  });

  test('isExpandedUp', () {
    expect(SizeClass.medium.isExpandedUp, isFalse);
    expect(SizeClass.expanded.isExpandedUp, isTrue);
    expect(SizeClass.large.isExpandedUp, isTrue);
  });
}
