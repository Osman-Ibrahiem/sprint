import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/core/adaptive/pane_scope.dart';
import 'package:sprint/core/adaptive/size_class.dart';

void main() {
  Widget probe(void Function(SizeClass) onClass) => Builder(
    builder: (context) {
      onClass(PaneScope.of(context));
      return const SizedBox.shrink();
    },
  );

  testWidgets('falls back to window class without a PaneScope', (tester) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    SizeClass? seen;
    await tester.pumpWidget(MaterialApp(home: probe((s) => seen = s)));
    expect(seen, SizeClass.large);
  });

  testWidgets('class follows the pane width, not the window', (tester) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    SizeClass? seen;
    await tester.pumpWidget(
      MaterialApp(
        home: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: 360,
            child: PaneScope(child: probe((s) => seen = s)),
          ),
        ),
      ),
    );
    expect(seen, SizeClass.compact);
  });

  testWidgets('tokensOf returns the pane tokens', (tester) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    double? margin;
    await tester.pumpWidget(
      MaterialApp(
        home: Center(
          child: SizedBox(
            width: 900,
            child: PaneScope(
              child: Builder(
                builder: (context) {
                  margin = PaneScope.tokensOf(context).margin;
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      ),
    );
    expect(margin, 40);
  });
}
