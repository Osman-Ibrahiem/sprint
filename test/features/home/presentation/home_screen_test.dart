import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sprint/core/adaptive/size_class.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/core/theme/app_theme.dart';
import 'package:sprint/features/home/data/mock_home_repository.dart';
import 'package:sprint/features/home/domain/entities/user_affiliation.dart';
import 'package:sprint/features/home/domain/home_session.dart';
import 'package:sprint/features/home/presentation/home_layout.dart';
import 'package:sprint/features/home/presentation/providers/home_providers.dart';
import 'package:sprint/features/home/presentation/screens/home_screen.dart';
import 'package:sprint/features/home/presentation/widgets/facility_card.dart';

Widget _app(
  HomeSession session, {
  UserAffiliation affiliation = UserAffiliation.universityAffiliated,
  List<String>? visited,
}) {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (_, _) => HomeScreen(session: session),
      ),
      GoRoute(
        path: '/login',
        builder: (_, _) {
          visited?.add('/login');
          return const Scaffold(body: Text('login-page'));
        },
      ),
    ],
  );
  return ProviderScope(
    overrides: [
      homeRepositoryProvider.overrideWithValue(
        MockHomeRepository(affiliation: affiliation, latency: Duration.zero),
      ),
    ],
    child: MaterialApp.router(
      theme: AppTheme.dark(),
      locale: const Locale('ar'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    ),
  );
}

Future<void> _pump(
  WidgetTester tester,
  Widget app, {
  Size size = const Size(360, 800),
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(app);
  await tester.pumpAndSettle();
}

void main() {
  test('columnsFor follows the size class', () {
    expect(HomeLayout.columnsFor(SizeClass.compact), 1);
    expect(HomeLayout.columnsFor(SizeClass.medium), 2);
    expect(HomeLayout.columnsFor(SizeClass.expanded), 3);
    expect(HomeLayout.columnsFor(SizeClass.large), 3);
  });

  group('guest', () {
    testWidgets('shows hero, full prices, no navigation', (tester) async {
      await _pump(tester, _app(HomeSession.guest));
      expect(find.text('احجز ملعبك من غير زحمة'), findsOneWidget);
      expect(find.byType(FacilityCard), findsWidgets);
      expect(find.text('120 ج.م / ساعة'), findsOneWidget);
      expect(find.textContaining('أهلاً يا'), findsNothing);
      expect(find.byType(NavigationBar), findsNothing);
      expect(find.byType(NavigationRail), findsNothing);
    });

    testWidgets('hero CTA, top-bar button and cards go to login', (
      tester,
    ) async {
      final visited = <String>[];
      await _pump(tester, _app(HomeSession.guest, visited: visited));
      await tester.tap(find.text('سجّل دخولك واحجز'));
      await tester.pumpAndSettle();
      expect(find.text('login-page'), findsOneWidget);

      await _pump(tester, _app(HomeSession.guest));
      await tester.tap(find.text('دخول'));
      await tester.pumpAndSettle();
      expect(find.text('login-page'), findsOneWidget);

      await _pump(tester, _app(HomeSession.guest));
      await tester.tap(find.byType(FacilityCard).first);
      await tester.pumpAndSettle();
      expect(find.text('login-page'), findsOneWidget);
    });
  });

  group('booker', () {
    testWidgets('greeting, upcoming booking, discounted price, bottom bar', (
      tester,
    ) async {
      await _pump(tester, _app(HomeSession.booker));
      expect(find.text('أهلاً يا أحمد'), findsOneWidget);
      expect(find.text('حجزك الجاي'), findsOneWidget);
      expect(find.text('60 ج.م / ساعة'), findsOneWidget);
      expect(find.text('120 ج.م'), findsOneWidget); // struck-through original
      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.byType(NavigationDestination), findsNWidgets(4));
    });

    testWidgets('external booker sees full price only', (tester) async {
      await _pump(
        tester,
        _app(HomeSession.booker, affiliation: UserAffiliation.external),
      );
      expect(find.text('120 ج.م / ساعة'), findsOneWidget);
      expect(find.text('60 ج.م / ساعة'), findsNothing);
    });

    testWidgets('other destinations show coming soon', (tester) async {
      await _pump(tester, _app(HomeSession.booker));
      await tester.tap(find.text('حجوزاتي'));
      await tester.pumpAndSettle();
      expect(find.text('قريبًا'), findsOneWidget);
      expect(find.byType(FacilityCard), findsNothing);
    });
  });

  group('adaptive navigation', () {
    for (final entry in {
      const Size(800, 900): 2,
      const Size(1000, 800): 3,
      const Size(1400, 900): 3,
    }.entries) {
      testWidgets('${entry.key} uses a rail and ${entry.value} columns', (
        tester,
      ) async {
        await _pump(tester, _app(HomeSession.booker), size: entry.key);
        expect(find.byType(NavigationRail), findsOneWidget);
        expect(find.byType(NavigationBar), findsNothing);
        final grid = tester.widget<SliverGrid>(find.byType(SliverGrid));
        final delegate =
            grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
        expect(delegate.crossAxisCount, entry.value);
        expect(tester.takeException(), isNull);
      });
    }

    testWidgets('large window extends the rail', (tester) async {
      await _pump(
        tester,
        _app(HomeSession.booker),
        size: const Size(1400, 900),
      );
      expect(
        tester.widget<NavigationRail>(find.byType(NavigationRail)).extended,
        isTrue,
      );
    });

    testWidgets('narrow 320 dp guest does not overflow', (tester) async {
      await _pump(tester, _app(HomeSession.guest), size: const Size(320, 640));
      expect(tester.takeException(), isNull);
    });
  });

  testWidgets('load failure shows retry', (tester) async {
    var fail = true;
    final app = ProviderScope(
      overrides: [
        homeContentProvider.overrideWith((ref, session) {
          if (fail) throw Exception('boom');
          return ref.watch(getHomeContentProvider)(session);
        }),
        homeRepositoryProvider.overrideWithValue(
          const MockHomeRepository(latency: Duration.zero),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.dark(),
        locale: const Locale('ar'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const HomeScreen(session: HomeSession.guest),
      ),
    );
    await _pump(tester, app);
    expect(find.text('حصلت مشكلة وإحنا بنحمل الصفحة'), findsOneWidget);
    fail = false;
    await tester.tap(find.text('حاول تاني'));
    await tester.pumpAndSettle();
    expect(find.byType(FacilityCard), findsWidgets);
  });
}
