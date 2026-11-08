// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Swap this for the Supabase-backed repository when the backend lands.

@ProviderFor(homeRepository)
final homeRepositoryProvider = HomeRepositoryProvider._();

/// Swap this for the Supabase-backed repository when the backend lands.

final class HomeRepositoryProvider
    extends $FunctionalProvider<HomeRepository, HomeRepository, HomeRepository>
    with $Provider<HomeRepository> {
  /// Swap this for the Supabase-backed repository when the backend lands.
  HomeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeRepositoryHash();

  @$internal
  @override
  $ProviderElement<HomeRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HomeRepository create(Ref ref) {
    return homeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeRepository>(value),
    );
  }
}

String _$homeRepositoryHash() => r'fb4f0de04e88837063c9071e5a6bbf03f219acd6';

@ProviderFor(getHomeContent)
final getHomeContentProvider = GetHomeContentProvider._();

final class GetHomeContentProvider
    extends $FunctionalProvider<GetHomeContent, GetHomeContent, GetHomeContent>
    with $Provider<GetHomeContent> {
  GetHomeContentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getHomeContentProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getHomeContentHash();

  @$internal
  @override
  $ProviderElement<GetHomeContent> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetHomeContent create(Ref ref) {
    return getHomeContent(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetHomeContent value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetHomeContent>(value),
    );
  }
}

String _$getHomeContentHash() => r'945beeb387c43293f478df2289cd15d00993d74e';

@ProviderFor(homeContent)
final homeContentProvider = HomeContentFamily._();

final class HomeContentProvider
    extends
        $FunctionalProvider<
          AsyncValue<HomeContent>,
          HomeContent,
          FutureOr<HomeContent>
        >
    with $FutureModifier<HomeContent>, $FutureProvider<HomeContent> {
  HomeContentProvider._({
    required HomeContentFamily super.from,
    required HomeSession super.argument,
  }) : super(
         retry: null,
         name: r'homeContentProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$homeContentHash();

  @override
  String toString() {
    return r'homeContentProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<HomeContent> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<HomeContent> create(Ref ref) {
    final argument = this.argument as HomeSession;
    return homeContent(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is HomeContentProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$homeContentHash() => r'c0d747ca1f8cc119c70cdc8b3c28d169b5acf585';

final class HomeContentFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<HomeContent>, HomeSession> {
  HomeContentFamily._()
    : super(
        retry: null,
        name: r'homeContentProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  HomeContentProvider call(HomeSession session) =>
      HomeContentProvider._(argument: session, from: this);

  @override
  String toString() => r'homeContentProvider';
}

@ProviderFor(HomeNav)
final homeNavProvider = HomeNavProvider._();

final class HomeNavProvider
    extends $NotifierProvider<HomeNav, HomeDestination> {
  HomeNavProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeNavProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeNavHash();

  @$internal
  @override
  HomeNav create() => HomeNav();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeDestination value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeDestination>(value),
    );
  }
}

String _$homeNavHash() => r'b7cddfc8d9999f6e63a8f1cfb67f1ce346c97d33';

abstract class _$HomeNav extends $Notifier<HomeDestination> {
  HomeDestination build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<HomeDestination, HomeDestination>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<HomeDestination, HomeDestination>,
              HomeDestination,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
