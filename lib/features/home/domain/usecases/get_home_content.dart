import 'package:sprint/features/home/domain/entities/home_content.dart';
import 'package:sprint/features/home/domain/home_session.dart';
import 'package:sprint/features/home/domain/repositories/home_repository.dart';

/// Loads Home content for [session]. Guests never get personal data, even
/// if a repository returns it.
class GetHomeContent {
  const GetHomeContent(this._repository);

  final HomeRepository _repository;

  Future<HomeContent> call(HomeSession session) async {
    final content = await _repository.load(session);
    if (session == HomeSession.guest && !content.isGuest) {
      return HomeContent(facilities: content.facilities);
    }
    return content;
  }
}
