import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sprint/features/home/data/mock_home_repository.dart';
import 'package:sprint/features/home/domain/entities/home_content.dart';
import 'package:sprint/features/home/domain/home_session.dart';
import 'package:sprint/features/home/domain/repositories/home_repository.dart';
import 'package:sprint/features/home/domain/usecases/get_home_content.dart';

part 'home_providers.g.dart';

/// Swap this for the Supabase-backed repository when the backend lands.
@Riverpod(keepAlive: true)
HomeRepository homeRepository(Ref ref) => const MockHomeRepository();

@riverpod
GetHomeContent getHomeContent(Ref ref) =>
    GetHomeContent(ref.watch(homeRepositoryProvider));

@riverpod
Future<HomeContent> homeContent(Ref ref, HomeSession session) =>
    ref.watch(getHomeContentProvider)(session);

/// Navigation destinations of the signed-in shell.
enum HomeDestination { home, bookings, notifications, profile }

@riverpod
class HomeNav extends _$HomeNav {
  @override
  HomeDestination build() => HomeDestination.home;

  void select(HomeDestination destination) => state = destination;
}
